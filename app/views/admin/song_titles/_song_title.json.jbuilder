json.extract! song_title, :id, :title_en, :title_ru, :created_at, :updated_at
json.url song_title_url(song_title, format: :json)
