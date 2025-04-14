class CreateTableEmployees < ActiveRecord::Migration[8.0]
  def change
    create_table :employees do |t|
      t.string :full_name
      t.string :position
      t.string :department
      t.text :face_encoding
      t.string :image_file_path
      
      t.timestamps
    end
  end
end
