class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    resource_params = {}
    resource_params[:f] = params[:f].to_json if params[:f].present?
    resource_params[:page] = params[:page].present? ? params[:page] : 1

    @contacts = Contact.all(params: resource_params)

    @contacts = Kaminari::PaginatableArray.new(@contacts,{
      limit: @contacts.http_response['X-limit'].to_i,
      offset: @contacts.http_response['X-offset'].to_i,
      total_count: @contacts.http_response['X-total'].to_i
    })
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @contact.update_attribute(:read, true)
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.js { render :show, status: :created, location: @contact }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.js { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update_attributes(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /contacts.js
  def update_many
    begin
      Contact.put(:many, contact_params.merge({ ids: params[:ids] }))
    rescue
      @contacts_errors = ['Unable to update selected contacts']
    end
    @contacts = Contact.all(params: { f: { select: params[:ids] }.to_json })
    render :index
  end

  # DELETE /contacts.js
  def destroy_many
    param_ids = { ids: params[:ids] }
    begin
      Contact.delete(:many, param_ids)
      render js: 'window.location.reload()'
    rescue
      @contacts = Contact.all(params: { f: { select: params[:ids] }.to_json })
      @contacts_errors = ['Unable to delete selected contacts']
      render :index
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name, :email, :tel, :message, :role, :subject, :read)
    end
end
