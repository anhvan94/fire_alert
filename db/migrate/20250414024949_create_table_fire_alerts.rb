class CreateTableFireAlerts < ActiveRecord::Migration[8.0]
  def change
    create_table :fire_alerts do |t|
      t.datetime :timestamp
      t.string :location
      t.string :camera_id
      t.string :image_file_path
      t.float :confidence_score
      t.string :status
      t.boolean :is_sent_to_web, default: false

      t.timestamps
    end
  end
end
