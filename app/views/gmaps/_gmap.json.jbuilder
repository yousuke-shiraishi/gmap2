json.extract! gmap, :id, :latitude, :longitude, :coment, :title, :created_at, :updated_at
json.url gmap_url(gmap, format: :json)
