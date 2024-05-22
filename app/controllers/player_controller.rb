class PlayerController < ApplicationController
  def fetch_audio
    key = params[:key]
    blob = ActiveStorage::Blob.find_by(key:, content_type: "audio/mpeg")

    raise ActionController::RoutingError, "Web-audio with the key: '#{key}' is not found" unless blob

    redirect_to blob
  end
end
