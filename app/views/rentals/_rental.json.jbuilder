json.extract! rental, :id, :name, :start_time, :end_time, :game_id, :created_at, :updated_at
json.url rental_url(rental, format: :json)