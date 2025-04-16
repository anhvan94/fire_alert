ActiveAdmin.register FireAlert do
  permit_params :timestamp, :location, :camera_id, :image_file_path, :confidence_score, :status, :is_sent_to_web

  index do
    selectable_column
    id_column
    column :timestamp
    column :location
    column :camera_id

    column "Image" do |fire_alert|
      if fire_alert.image_file_path.present?
        begin
          full_image_url = "#{request.protocol}#{request.host_with_port}#{fire_alert.image_file_path}"
          
          image_tag(full_image_url, style: "width: 300px; height: 300px; object-fit: contain; max-width: 400px; max-height: 400px; margin: 0 auto;")
        rescue StandardError => e
          status_tag "Invalid Image URL", class: "error"
        end
      else
        status_tag "No Image", class: "warning"
      end
    end

    column :confidence_score
    column :status
    column :is_sent_to_web
    actions
  end
end
