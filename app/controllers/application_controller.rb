require 'mailchimp'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :setup_mcapi
  
  def setup_mcapi
    @mc = Mailchimp::API.new(ENV['MAILCHIMP_API_KEY'])
    @list_id = ENV["LIST_ID"]
  end
  
end
