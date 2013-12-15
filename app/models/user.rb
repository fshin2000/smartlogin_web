class User < ActiveRecord::Base
  validates :login_id , :presence=> true
  validates :password , :presence=> true
  validates :name , :presence=>true
  validates :mail_address , :presence=>true
  
end
