Rails.application.routes.draw do
  get    '/auth'            => 'session_authentication#new'
  post   '/create_session'  => 'session_authentication#create'
  delete '/sign_out'        => 'session_authentication#destroy'
  post   '/set_token_user'  => 'token_authentication#create'
end
