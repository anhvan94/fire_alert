class ImageUploaderService
  BASE_UPLOAD_DIR = "public/uploads"

  def self.save(uploaded_file, model_name:, record_id:)
    return nil unless uploaded_file.respond_to?(:original_filename)

    # Lấy phần mở rộng
    ext = File.extname(uploaded_file.original_filename).downcase
    ext = ".jpg" if ext.blank?

    # Tạo đường dẫn thư mục theo model + id
    subdir = "#{model_name}/#{record_id}"
    full_dir_path = Rails.root.join(BASE_UPLOAD_DIR, subdir)
    FileUtils.mkdir_p(full_dir_path) unless Dir.exist?(full_dir_path)

    # Tên file cố định là original.jpg
    file_name = "original#{ext}"
    file_path = full_dir_path.join(file_name)

    # Ghi file
    File.open(file_path, "wb") { |file| file.write(uploaded_file.read) }

    # Trả về URL tương đối (phục vụ frontend)
    "/uploads/#{subdir}/#{file_name}"
  end
end
