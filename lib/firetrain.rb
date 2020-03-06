require 'firetrain/railtie'
require 'firebase_id_token'

module FireTrain
  FirebaseIdToken::Certificates.request! if ENV['RAILS_ENV'] == 'development'

  autoload :Authentication, 'firetrain/authentication'
  module Controllers
    autoload :Authenticatable, 'firetrain/controllers/authenticatable'
  end

  class Engine < ::Rails::Engine
    initializer "firetrain.precompile" do |app|
      app.config.assets.paths << Rails.root.join('/engines/firetrain/app/assets/javascripts')
      app.config.assets.precompile << "firetrain/application.js"
    end
  end
end
