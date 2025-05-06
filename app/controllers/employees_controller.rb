class EmployeesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    uploaded_file = params[:image]

    employee = Employee.new(
      full_name: params[:full_name],
      position: params[:position],
      department: params[:department],
      face_encoding: params[:face_encoding]
    )

    if employee.save
      if uploaded_file.present?
        image_path = ImageUploaderService.save(
          uploaded_file,
          model_name: "employees",
          record_id: employee.id
        )

        employee.update(image_file_path: image_path)
      end

      render json: { message: 'Employee created successfully', employee: employee }, status: :created
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    employee = Employee.find(params[:id])
    uploaded_file = params[:image]

    if employee.update(employee_params.except(:image))
      if uploaded_file.present?
        image_path = ImageUploaderService.save(
          uploaded_file,
          model_name: "employees",
          record_id: employee.id
        )

        employee.update(image_file_path: image_path)
      end

      render json: { message: 'Employee updated successfully', employee: employee }, status: :ok
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def employee_params
    params.require(:employee).permit(
      :full_name,
      :position,
      :department,
      :face_encoding,
      :image_file_path
    )
  end
end
