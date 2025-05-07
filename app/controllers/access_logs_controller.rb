class AccessLogsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    uploaded_file = params[:image]
  
    access_log = AccessLog.new(
      employee_id: params[:employee_id],
      timestamp: params[:timestamp],
      status: params[:status],
      device_id: params[:device_id]
    )
  
    if access_log.save
      if uploaded_file.present?
        image_path = ImageUploaderService.save(
          uploaded_file,
          model_name: "access_logs",
          record_id: access_log.id
        )
  
        access_log.update(image_file_path: image_path)
      end
  
      render json: { message: 'Access Log created successfully', access_log: access_log }, status: :created
    else
      render json: { errors: access_log.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def access_log_params
    params.require(:access_log).permit(
      :employee_id,
      :timestamp,
      :status,
      :device_id,
      :image_file_path
    )
  end
end
