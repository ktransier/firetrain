FirebaseIdToken.configure do |config|
  config.project_ids = [ENV['FIRETRAIN_PROJECT_ID']]
  if ENV['RAILS_ENV'] == 'test'
  	config.redis = MockRedis.new
  end
end
