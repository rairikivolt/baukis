class Customer < ActiveRecord::Base
  has_one :home_address, dependent: :destroy, autosave: true #destroy > :destroy
  has_one :work_address, dependent: :destroy, autosave: true

  before_validation do
    self.email_for_index = email.downcase if email
  end

  validates :gender, inclusion: { in: %w(male female), allow_blank: true }
  validates :birthday, date: {
    after: Date.new(1900, 1, 1),
    before: -> (obj) { Date.today },
    allow_blank: true
  }

  def password=(raw_password) # passsword > password
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?  # else > elsif
      self.hashed_password = nil
    end
  end
end
