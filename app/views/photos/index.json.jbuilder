json.array!(@photos) do |photo|
  json.extract! photo, :id, :title, :public, :image, :description, :user_id, :type, :size, :slug, :views
  json.url photo_url(photo, format: :json)
end
