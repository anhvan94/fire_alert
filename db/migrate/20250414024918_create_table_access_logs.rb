class CreateTableAccessLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :access_logs do |t|
      t.references :employee, foreign_key: true
      t.datetime :timestamp
      t.string :status
      t.string :device_id
      t.string :image_file_path

      t.timestamps
    end
  end
end
