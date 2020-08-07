module ControllerHelpers
  def login(user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in(user)
  end

  def create_file_blob(filename: "image.jpg", content_type: "image/jpeg", metadata: nil)
    ActiveStorage::Blob.create_after_upload!(io: file_fixture(filename).open, filename: filename, content_type: content_type, metadata: metadata)
  end
end