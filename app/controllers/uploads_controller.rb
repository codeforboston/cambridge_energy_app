class UploadsController < ApplicationController
  def new
    @upload = Upload.new
  end

  def create
    upload_io = params[:upload][:xml]
    xml       = upload_io.read
    data_hash = Hash.from_xml(xml)
    json      = data_hash.to_json

    @upload = Upload.new(
      filename: upload_io.original_filename,
      jdoc: json,
      xml: xml,
      user: current_user
      )
    if @upload.save
      @upload.create_bills_from_xml
      redirect_to confirmation_upload_path(@upload)
    else
      render :new
    end
  end

  def confirmation
    @upload = Upload.find(params[:id])
    @user = User.find(@upload.user_id)
  end

  def allowed_params
    params.require(:upload).permit(:xml)
  end
end
