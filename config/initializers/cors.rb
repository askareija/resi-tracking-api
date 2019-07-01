# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:8080', '127.0.0.1:8080', 'localhost:5000', 'resi-tracking.herokuapp.com', '1b8dbb5f.ngrok.io'
    # origins '*'

    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             expose: true,
             credentials: true
  end
end
