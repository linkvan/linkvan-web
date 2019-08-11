class Api::SessionsController < Api::ApplicationController
	def create
		if user = User.authenticate(params[:email], params[:password])
			session[:user_id] = user.id
			if !cookies['non_data_user'].present?
				cookies['non_data_user'] = 'true'
			end
		else
			error_json = { error: 'Email or Password invalid, please try again.' }
			render json: error_json, status: :unauthorized
		end
		head :no_content
	end

	def destroy
		session[:user_id] = nil
		head :no_content
	end
end
