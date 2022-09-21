module ApiAuthenticable
	
	def generate_token
		exp_date = Time.now + 24*60*60
		payload = {
			email: params[:email],
			password: params[:password],
			exp: exp_date.to_i
		}
		token = JWT.encode payload, nil, 'none'
		payload = {
			is_valid: true,
			token: token
		}
	end

	def user_login
		email_password_present = params[:email] == 'admin@gmail.com' && params[:password] == '123456'

		if email_password_present
			generate_token
		else
			payload = {
				is_valid: false,
				token: nil
			}
		end
	end

	def authenticate_user
		if params[:token]
			payload = JWT.decode params[:token], nil, false
			exp_date = payload.first['exp']

			if exp_date < Time.now.to_i
				false
			elsif exp_date > Time.now.to_i
				true
			end
		elsif !params[:token]
			false
		else
			false
		end
	rescue => e
		false
	end
end