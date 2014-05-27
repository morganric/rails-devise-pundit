json.array!(@profiles) do |profile|
  json.extract! profile, :id, :display_name, :bio, :image, :website, :date_of_birth, :location, :user_id, :latitude, :longitude
  json.url profile_url(profile, format: :json)
end
