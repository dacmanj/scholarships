class HomeController < ApplicationController
  skip_authorize_resource :only => :index

  def index
    @users = User.all
  end
end
