json.extract! loan, :id, :user_id, :item_id, :requested_at, :fulfilled_at, :returned_at, :status, :created_at, :updated_at
json.url loan_url(loan, format: :json)
