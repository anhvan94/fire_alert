ActiveAdmin.register Employee do
  permit_params :full_name, :position, :department, :face_encoding, :image_file_path

  form do |f|
    f.inputs do
      f.input :full_name
      f.input :position
      f.input :department
      f.input :face_encoding
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
      @employee = Employee.new(permitted_params[:employee].except(:image_file_path))

      if @employee.save
        if params[:employee][:image_file_path].present?
          image_path = ImageUploaderService.save(
            params[:employee][:image_file_path],
            model_name: "employees",
            record_id: @employee.id
          )
          @employee.update(image_file_path: image_path)
        end
        flash[:notice] = "Employee created successfully"
        redirect_to admin_employee_path(@employee)
      else
        flash.now[:error] = @employee.errors.full_messages.join(", ")
        render :new
      end
    end

    def update
      @employee = Employee.find(params[:id])
      employee_params = permitted_params[:employee].except(:image_file_path)

      if @employee.update(employee_params)
        if params[:employee][:image_file_path].present?
          image_path = ImageUploaderService.save(
            params[:employee][:image_file_path],
            model_name: "employees",
            record_id: @employee.id
          )
          @employee.update(image_file_path: image_path)
        end
        flash[:notice] = "Employee updated successfully"
        redirect_to admin_employee_path(@employee)
      else
        flash.now[:error] = @employee.errors.full_messages.join(", ")
        render :edit
      end
    end
  end

  index do
    selectable_column
    id_column
    column :full_name
    column :position
    column :department
    column :image_file_path do |employee|
      if employee.image_file_path.present?
        image_tag employee.image_file_path, size: "100x100", style: 'object-fit: contain;'
      else
        "No image"
      end
    end
    actions
  end
end
