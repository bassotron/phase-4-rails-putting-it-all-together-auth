class UsersController < ApplicationController
	rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
	skip_before_action :authorize, only: [:create]
def create
	user = User.create!(user_params)
	session[:user_id] = user.id
	render json: user, status: :created
	end

def show
	user = User.find_by(id: session[:user_id])
	if session[:user_id] = user.id
	render json: user, only: [:id, :username, :image_url, :bio], status: :created
    else
		render json: { errors: ["Unauthorized"] }, status: :unauthorized
	end
end



private

def user_params
	params.permit(:user_id, :username, :image_url, :password, :password_confirmation, :password_digest, :bio)
end

def render_unprocessable_entity_response(exception)
	render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end



end
