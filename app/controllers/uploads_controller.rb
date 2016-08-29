class UploadsController < ApplicationController
  before_action :authorize_user
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
      redirect_to upload_path(@upload), notice: 'Upload successful!'
    else
      render :new
    end
  end

  def show
    @upload = Upload.find(params[:id])
    @user = User.find(@upload.user_id)
    @bills = Bill.where(upload_id: @upload.id)
  end

  def allowed_params
    params.require(:upload).permit(:xml)
  end

  private

  def authorize_user
    authorize Upload
  end
end
