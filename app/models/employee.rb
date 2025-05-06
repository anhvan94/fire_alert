class Employee < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      full_name
      position
      department
      face_encoding
      image_file_path
      created_at
      updated_at
    ]
  end
end
