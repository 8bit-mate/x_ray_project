class Admin::AttachmentsController < ApplicationController
  include AdministrableController

  def purge
    attachment = ActiveStorage::Attachment.find(params[:id])
    attachment.purge_later
  end
end
