json.extract! user, :id, :email, :image, :name, :birth, :password_digest, :created_at, :updated_at
json.url user_url(user, format: :json)
