class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization :unless => :devise_controller?

  def after_sign_in_path_for(resource)
    redirect_path = root_path
    if current_user.is? :student
      if (Application.find_by_uid current_user.id).blank?
        redirect_path = new_application_path
      else
        redirect_path = edit_application_path Application.find_by_uid current_user.id
      end
    end
    if current_user.is? :admin
        if Time.now.to_date > Date::strptime(ENV["DEADLINE"],"%m-%d-%Y")
            redirect_path = applications_path(:transcript => 1, :signed => 1, :reference => 1, :essay => 1)
        else
            redirect_path = applications_path
        end
    elsif current_user.is? :reviewer
      redirect_path = applications_path
    end
    redirect_path
  end


  rescue_from CanCan::AccessDenied do |exception|
  	if current_user.nil?
      session[:next] = request.fullpath
      puts session[:next]
      redirect_to root_url, :alert => "You have to log in to continue."
    else
      #render :file => "#{Rails.root}/public/403.html", :status => 403
      if request.env["HTTP_REFERER"].present?
        redirect_to :back, :alert => exception.message
      else
        redirect_to root_url, :alert => exception.message
      end
  	end
  end
end
