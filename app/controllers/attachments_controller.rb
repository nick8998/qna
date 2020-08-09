class AttachmentsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_file

  def destroy
    if current_user.author_of?(@file.record)
      @file.purge
    end
  end

  private

  def find_file
    @file = ActiveStorage::Attachment.find(params[:id])
  end
end
