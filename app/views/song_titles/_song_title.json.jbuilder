json.extract! song_title, :id, :created_at, :updated_at
json.url song_title_url(song_title, format: :json)
