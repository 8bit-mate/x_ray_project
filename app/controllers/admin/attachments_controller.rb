class Admin::AttachmentsController < ApplicationController
  include AdministrableController

  def purge
    puts("#{params[:id]}FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF")
    attachment = ActiveStorage::Attachment.find(params[:id])
    attachment.purge_later
  end
end
