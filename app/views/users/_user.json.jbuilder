json.extract! user, :id, :name, :email, :admin, :last_sign_in_at, :loans_count, :created_at, :updated_at
json.url user_url(user, format: :json)
