class UsersController < ApplicationController
#  before_filter :authenticate_user!
  skip_authorize_resource :only => [:new, :create]
  load_and_authorize_resource
  before_filter :filter_users, :only => :index

  
  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = @users.paginate(:page => params[:page]) 

  end

  def show
    @user = User.find(params[:id])
  end
  
  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
  private
  def filter_users
    @users = @users.where("name ILIKE ?","%#{params[:name]}%") if params[:name].present?
    @users = @users.where("email ILIKE ?","%#{params[:email]}%") if params[:email].present?
    @users = @users.with_role(params[:role]) if params[:role].present?
    @users = @users.order("created_at desc") if params[:order] == 'registered_desc'
    @users = @users.order("created_at asc") if params[:order] == 'registered_asc'
    @users = @users.order("name asc") if params[:order] == 'name_asc'
    @users = @users.order("name desc") if params[:order] == 'name_desc'

  end
end

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
  end
end