# -*- encoding: UTF-8 -*-

require 'net/http'
require 'uri'
require "rqrcode"

class IndexController < ApplicationController


  def index

    @server_ip = SERVER_IP;
          
  end

  def qrcode

    sid = params['sid'].to_s
    p sid
    @qr = RQRCode::QRCode.new("http://" + SERVER_IP + ":3000/loginpolicy?sid=" + sid , :size  => 7, :level => :h )

  end
  
  
  def loginpolicy
    
     policy = {
       "policy_version"=>1.0 ,
       "lang"=>"ja" , 
       "domain"=>"http://smartlogin.f-shin.net",
       "service_name"=>"smart login sample" ,
       "service_description"=>"簡単ログインサンプルです" ,
       "service_icon"=>"http://smartlogin.f-shin.net/images/icon.png",
       "register_url"=>"http://smartlogin.f-shin.net/register",
       "login_url"=>"http://" + SERVER_IP + ":3000/login",
       "login_usable_character"=>"A-Za-z+-" ,
       "id_type"=>"mail" ,
       "passwd_count_min"=>6,
       "passwd_count_max"=>13 , 
       "term_url"=>"http://smartlogin.f-shin.net/terms",
       "user_icon_required"=>"yes" , 
       "user_icon_width"=>300 , 
       "user_icon_height"=> 200 , 
       "mail_address_required"=>"yes"
     }
    
     render :json=>policy

    
  end
  
  def login
    
    login_id = params['login_id']
    password = params['password']
    
    
  end
  
  def register
    
    @user = User.new()
    @user.login_id = params['login_id']
    @user.password = hashed_password(params['password'] , @user.login_id)
    @user.icon_filename = params['icon_filename']
    @user.mail_address = params['mail_address']
    @user.name = params['name']
    
    unless @user.valid?
      makeErrorResponse("param is not found")
      return
    end
    ret = @user.save    
    if !ret
      makeErrorResponse("param is not found")
      return
    else
      response = {"status"=>true , "user_id"=>@user.id}
      render :json=>response
    end
    
  end
  
  def login

    if params['login_id'].present?
      login_id = params['login_id'].presence
    else
      makeErrorResponse("param is not found")
      return
    end

    ##todo：ログイン認証処理
    
    #node.jsonにログイン通知
    nodejs_response = Net::HTTP.get_response(URI.parse("http://" + SERVER_IP + ":4000"))

    if true
      # login 処理
      response = {"status"=>true , "user_id"=>100}
      render :json=>response
    else
      makeErrorResponse("unknow user")
      return
    end
    
  end
  
  def portal
    
    
  end
  
  # ハッシュ値の生成
  def self.hashed_password(password, salt)
    Digest::SHA1.hexdigest(sprintf("%s%08d", password, salt))
  end    
  
end
