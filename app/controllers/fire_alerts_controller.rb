class FireAlertsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    uploaded_file = params[:image]
  
    fire_alert = FireAlert.new(
      timestamp: params[:timestamp],
      location: params[:location],
      camera_id: params[:camera_id],
      confidence_score: params[:confidence_score],
      status: params[:status],
      is_sent_to_web: ActiveModel::Type::Boolean.new.cast(params[:is_sent_to_web])
    )
  
    if fire_alert.save
      if uploaded_file.present?
        image_path = ImageUploaderService.save(
          uploaded_file,
          model_name: "fire_alerts",
          record_id: fire_alert.id
        )
  
        fire_alert.update(image_file_path: image_path)
      end
  
      render json: { message: 'Fire alert created successfully', fire_alert: fire_alert }, status: :created
    else
      render json: { errors: fire_alert.errors.full_messages }, status: :unprocessable_entity
    end
  end
  

  private

  def fire_alert_params
    params.require(:fire_alert).permit(
      :timestamp,
      :location,
      :camera_id,
      :image_file_path,
      :confidence_score,
      :status,
      :is_sent_to_web
    )
  end
end
