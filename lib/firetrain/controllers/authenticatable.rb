module FireTrain
  module Controllers
    module Authenticatable
      def authenticate_session_user
        redirect_to auth_path unless authentication_manager.authenticate_session_user
      end

      def authenticate_api_user
        render json: {}, status: 401 unless authentication_manager.authenticate_api_user
      end

      def current_user
        authentication_manager.find_current_user
      end

      private

      def authentication_manager
        FireTrain::Authentication.new(
          session: session,
          token: request.headers["HTTP_FIREBASE_TOKEN"]
        )
      end
    end
  end
end
