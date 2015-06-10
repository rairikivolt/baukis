#StaffMemberオブジェクトを引数としてインスタンスかされ、そのインスタンスメソッドauthenticateにログインフォームに入力された平文のパスワードを渡してユーザー認証を行う
class Staff::Authenticator
  def initialize(staff_member)
    @staff_member = staff_member
  end

  def authenticate(raw_password)
    @staff_member &&
    @staff_member.hashed_password &&
    @staff_member.start_date <= Date.today &&
    (@staff_member.end_date.nil? || @staff_member.end_date > Date.today) &&
    # "=="は比較演算子ではなく、BCrypt::Passwordオブジェクトのインスタンスメソッド。引数に指定された平文のパスワードをハッシュ関数で計算し、自分自身の保持ているハッシュ値と同じであればTrueを返す。
    BCrypt::Password.new(@staff_member.hashed_password) == raw_password
  end
end
#no issues
