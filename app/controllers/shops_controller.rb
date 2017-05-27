class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]

  # GET /shops
  # GET /shops.json
  def index
    resource_params = {}
    resource_params[:f] = params[:f].to_json if params[:f].present?
    resource_params[:page] = params[:page].present? ? params[:page] : 1
    resource_params[:per] = params[:per].present? ? params[:per] : 12

    @shops = Shop.all(params: resource_params)

    @shops = Kaminari::PaginatableArray.new(@shops,{
      limit: @shops.http_response['X-limit'].to_i,
      offset: @shops.http_response['X-offset'].to_i,
      total_count: @shops.http_response['X-total'].to_i
    })

    @categories = Category.all
    @sheds = Shed.all
    @users = User.all(params: { f: { scopes: { role: :seller } } })
  end

  # GET /shops/1
  # GET /shops/1.json
  def show
    @user = User.find(@shop.user_id)
    @shed = Shed.find(@shop.shed_id)
    @category = Category.find(@shop.category_id)
  end

  # GET /shops/new
  def new
    @shop = Shop.new
  end

  # GET /shops/1/edit
  def edit
  end

  # POST /shops
  # POST /shops.json
  def create
    @shop = Shop.new(shop_params)

    respond_to do |format|
      if @shop.save
        format.html { redirect_to @shop, notice: 'Shop was successfully created.' }
        format.json { render :show, status: :created, location: @shop }
      else
        format.html { render :new }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shops/1
  # PATCH/PUT /shops/1.json
  def update
    respond_to do |format|
      if @shop.update_attributes(shop_params)
        format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
        format.json { render :show, status: :ok, location: @shop }
      else
        format.html { render :edit }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to shops_url, notice: 'Shop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /shops.js
  def update_many
    begin
      Shop.put(:many, shop_params.merge({ ids: params[:ids] }))
    rescue
      @shops_errors = ['Unable to update selected shops']
    end
    @shops = Shop.all(params: { f: { select: params[:ids] }.to_json })
    render :index
  end

  # DELETE /shops.js
  def destroy_many
    param_ids = { ids: params[:ids] }
    begin
      Shop.delete(:many, param_ids)
      render js: 'window.location.reload()'
    rescue
      @shops = Shop.all(params: { f: { select: params[:ids] }.to_json })
      @shops_errors = ['Unable to delete selected shops']
      render :index
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_params
      params.require(:shop).permit(:user_id, :shed_id, :category_id, :description, :location, :location_detail, :location_floor, :location_row, :gallery_name, :number_id, :letter_id, :fixed, :opens, :condition, :status, :rating, :image, :image_file_name)
    end
end
