class MessagesController < ApplicationController
  
  include Auth

  before_filter :get_message_api
  
  def index
  end
  
  def show
    @message = @message_api.message(params[:id])
  end
  
  def destroy
    @message_api.delete(params[:id])
    redirect_to messages_url
  end
  
  def create
    m = params["/messages"]
    @message_api.create(m[:receipt], m[:content])
    redirect_to messages_url
  end
  
  private
  
  def get_message_api
    if params[:code] && session[:access_token].nil?
      auth_callback = get_access_token(params[:code]) 
      session[:access_token] = auth_callback["access_token"] if auth_callback
    end
    @message_api = MessageApi::User.new(session[:access_token]) if session[:access_token]
  end
  
end
