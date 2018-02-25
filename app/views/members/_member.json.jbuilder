json.extract! member, :id, :email, :image, :name, :birth, :password_digest, :created_at, :updated_at
json.url member_url(member, format: :json)
