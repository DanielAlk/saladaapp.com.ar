json.extract! payment, :id, :user_id, :payable_id, :payable_type, :transaction_amount, :mercadopago_preference, :payment_info, :init_point, :collection_id, :collection_status, :collection_status_detail, :preference_id, :payment_type, :created_at, :updated_at
json.url payment_url(payment, format: :json)