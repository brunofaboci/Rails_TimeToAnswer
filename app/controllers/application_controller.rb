class ApplicationController < ActionController::Base
  before_action :check_pagination
  before_action :set_global_params
  layout :layout_by_resource

  protected

  def layout_by_resource
    devise_controller? ? "#{resource_class.to_s.downcase}_devise" : 'application' 
  end

  def check_pagination
    unless user_signed_in?
      params.extract!(:page)
    end
  end

  def set_global_params
    $global_params = params
  end
  
  
end