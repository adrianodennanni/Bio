class UserController < ApplicationController
  
  def index
    @projects = Project.search(params[:search])
  end
  
end