ActiveAdmin.setup do |config|
  config.authentication_method = :authenticate_admin!
  config.current_user_method = :current_admin
  config.logout_link_path = :destroy_admin_session_path

  config.comments = true
  config.batch_actions = true
  config.site_title = "My Admin Panel"
end