class AccessLog < ApplicationRecord
  belongs_to :employee

  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      employee_id
      timestamp
      status
      device_id
      image_file_path
      created_at
      updated_at
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["employee"]
  end
end
