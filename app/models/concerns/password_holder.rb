module PasswordHolder
  extend ActiveSupport::Concern #ActiveRecord > ActiveSupport

  def password=(raw_password) # passsword > password
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?  # else > elsif
      self.hashed_password = nil
    end
  end
end
