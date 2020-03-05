module FireTrain
  class Authentication
    def initialize(session:, token:)
      @session = session
      @token = FirebaseIdToken::Signature.verify(token)
    end

    def authenticate_session_user
      @session[:user_id] && User.find(@session[:user_id]).present?
    end

    def authenticate_api_user
      User.find_by(
        email: @token["email"],
        firebase_id: @token["user_id"]
      ).present?
    end

    def find_or_create_user
      User.find_or_create_by(
        email: @token['email'],
        firebase_id: @token['user_id']
      )
    end

    def create_new_session
      @session[:user_id] = find_current_user.id
    end

    def find_current_user
      if @session[:user_id].present?
        User.find(@session[:user_id])
      elsif @token.present?
        User.find_by(
          email: @token["email"],
          firebase_id: @token["user_id"]
        )
      end
    end

    def sign_out
      @session[:user_id] = nil
    end
  end
end
