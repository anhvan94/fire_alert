ActiveAdmin.register AccessLog do
  permit_params :employee_id, :timestamp, :status, :device_id, :image_file_path

  form do |f|
    f.inputs do
      f.input :employee, as: :select, collection: Employee.all.map { |e| [e.full_name, e.id] }
      f.input :timestamp, as: :datetime_picker
      f.input :status
      f.input :device_id
      f.input :image_file_path, as: :file, input_html: { id: 'image_file_input' }
      div id: 'image_preview' do
        if f.object.image_file_path.present?
          image_tag f.object.image_file_path, size: '200x200', style: 'object-fit: contain;', id: 'current_image'
        end
      end
    end
    f.actions
    javascript_tag do
      <<-JS
        document.addEventListener('DOMContentLoaded', function() {
          const input = document.getElementById('image_file_input');
          if (input) {
            input.addEventListener('change', function(event) {
              const file = event.target.files[0];
              const preview = document.getElementById('image_preview');
              preview.innerHTML = '';

              if (file) {
                const img = document.createElement('img');
                img.src = URL.createObjectURL(file);
                img.style.width = '200px';
                img.style.height = '200px';
                img.style.objectFit = 'contain';
                preview.appendChild(img);
              }
            });
          }
        });
      JS
    end
  end

  controller do
    def create
      @access_log = AccessLog.new(permitted_params[:access_log].except(:image_file_path))

      if @access_log.save
        if params[:access_log][:image_file_path].present?
          image_path = ImageUploaderService.save(
            params[:access_log][:image_file_path],
            model_name: "access_logs",
            record_id: @access_log.id
          )
          @access_log.update(image_file_path: image_path)
        end
        flash[:notice] = "Access Log created successfully"
        redirect_to admin_access_log_path(@access_log)
      else
        flash.now[:error] = @access_log.errors.full_messages.join(", ")
        render :new
      end
    end

    def update
      @access_log = AccessLog.find(params[:id])
      access_log_params = permitted_params[:access_log].except(:image_file_path)

      if @access_log.update(access_log_params)
        if params[:access_log][:image_file_path].present?
          image_path = ImageUploaderService.save(
            params[:access_log][:image_file_path],
            model_name: "access_logs",
            record_id: @access_log.id
          )
          @access_log.update(image_file_path: image_path)
        end
        flash[:notice] = "Access Log updated successfully"
        redirect_to admin_access_log_path(@access_log)
      else
        flash.now[:error] = @access_log.errors.full_messages.join(", ")
        render :edit
      end
    end
  end

  index do
    selectable_column
    id_column
    column :employee do |access_log|
      access_log.employee&.full_name || "N/A"
    end
    column :timestamp
    column :status
    column :device_id
    column :image_file_path do |access_log|
      if access_log.image_file_path.present?
        image_tag access_log.image_file_path, size: "100x100", style: 'object-fit: contain;'
      else
        "No image"
      end
    end
    actions
  end
end