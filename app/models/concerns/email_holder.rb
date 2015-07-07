module EmailHolder
  extend ActiveSupport::Concern

  include do
    include StringNormalizer

    before_validation do
      self.email = normalize_as_email(email)
      self.email_for_index = email.downcase if email
    end

    validates :email, presence: true, email: { allow_blank: true }
    validates :email_for_index, uniqueness: { allow_blank: true}

    after_validation do
      if errors.include?(:email_for_index) #error > error's'
        errors.add(:email, :taken)
        errors.delete(:email_for_index)
      end
    end
  end
end
