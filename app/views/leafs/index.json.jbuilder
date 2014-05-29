json.array!(@leafs) do |leaf|
  json.extract! leaf, :id, :title, :copy, :image, :video, :audio, :url, :via_url, :live, :plays, :views, :user_id, :type
  json.url leaf_url(leaf, format: :json)
end
