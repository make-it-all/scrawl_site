Clearance.configure do |config|
config.routes = false
  config.mailer_sender = "reply@example.com"
  config.rotate_csrf_on_sign_in = true
end

Clearance::PasswordsController.layout "clearance_layout"
Clearance::SessionsController.layout "clearance_layout"
Clearance::UsersController.layout "clearance_layout"
