module Api
  module Authorizable extend ActiveSupport::Concern
    def generated_token
      email_and_id = "#{@user_id}:#{@email}"
      generated_token = crypt.encrypt_and_sign(email_and_id, expires_in: 10.minutes)
    end
    
    def validate_token
      return redirect_to root_path unless params[:token].present?
      
      decrypt = crypt.decrypt_and_verify(params[:token])
      return return_unauthorize unless decrypt.present?
            
      @user_id, @email = decrypt.split(":")
      return return_unauthorize unless @user_id.present? && @email.present?
    end

    def verify_authorization_token
      return return_unauthorize unless request.headers[:Authorization].present?
      authorization = request.headers[:Authorization]
      basic_auth = authorization.to_s.strip.split(' ').second
      return return_unauthorize unless basic_auth.present?

      decrypt = crypt.decrypt_and_verify(basic_auth)
      return return_unauthorize unless decrypt.present?
            
      @user_id, @email = decrypt.split(":")
      return return_unauthorize unless @user_id.present? && @email.present?
    end

    def return_unauthorize
      return render json: {
        status: 'UNAUTHORIZED',
        code: 401,
        message: "token authorization failed to verify.",
      }, status: :unauthorized
    end

    def crypt
      return @crypt if @crypt.present?
      pass = ENV["ACCOUNTING_TOKEN"]
      salt = ENV["ACCOUNTING_SALT"]
      key   = ActiveSupport::KeyGenerator.new(pass).generate_key(salt, 32)
      @crypt = ActiveSupport::MessageEncryptor.new(key)
    end
  end
end