class Api::AuthController < ApplicationController

	# PUT api/login
	def login
		head :no_content
	end #/login

	# GET api/logout
	def logout
		head :no_content
	end #/logout

end #/UsersController
