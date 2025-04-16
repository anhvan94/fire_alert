class FireAlert < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    %w[camera_id confidence_score created_at id image_file_path is_sent_to_web location status timestamp updated_at]
  end
  # validates :timestamp, :location, :camera_id, :image_file_path, :confidence_score, :status, presence: true
  # validates :confidence_score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
end