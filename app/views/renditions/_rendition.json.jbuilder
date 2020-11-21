json.extract! rendition, :id, :name, :description, :width, :height, :fps, :video_bitrate, :audio_bitrate, :container, :video_codec, :profile, :audio_codec, :created_at, :updated_at
json.url rendition_url(rendition, format: :json)
