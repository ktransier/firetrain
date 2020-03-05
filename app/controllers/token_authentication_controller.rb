class TokenAuthenticationController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def create
    respond_to do |format|
      if authentication_manager.find_or_create_user
        format.json { head :ok }
      else
        format.json { render json: { status: :unprocessable_entity } }
      end
    end
  end
end
