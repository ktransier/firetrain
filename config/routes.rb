Rails.application.routes.draw do
  get    '/api/auth'            => 'session_authentication#new'
  post   '/api/create_session'  => 'session_authentication#create'
  delete '/api/sign_out'        => 'session_authentication#destroy'
  post   '/api/set_token_user'  => 'token_authentication#create'
end
