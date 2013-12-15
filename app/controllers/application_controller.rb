class ApplicationController < ActionController::Base
  protect_from_forgery

  SERVER_IP = "172.20.10.5"


  def makeErrorResponse(reason)
      response = {"status"=>false , "reason"=>reason }
      render :json=>response
  end


end
