class ApplicationController < ActionController::Base
  include FireTrain::Controllers::Authenticatable
  helper FireTrain::Controllers::Authenticatable
end
