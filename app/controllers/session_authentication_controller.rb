class SessionAuthenticationController < ApplicationController
  def new
  end

  def create
    respond_to do |format|
      if authentication_manager.find_or_create_user
        authentication_manager.create_new_session
        format.json { head :ok }
      else
        format.json { render json: { status: :unprocessable_entity } }
      end
    end
  end

  def destroy
    authentication_manager.sign_out
    redirect_to :root
  end
end
