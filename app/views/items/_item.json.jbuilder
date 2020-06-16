json.extract! item, :id, :name, :category_id, :serial_number, :available, :created_at, :updated_at
json.url item_url(item, format: :json)
