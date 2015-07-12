#AdminMemberオブジェクトを引数としてインスタンス化され、そのインスタンスメソッドauthenticateにログインフォームに入力された平文のパスワードを渡してユーザー認証を行う
class Admin::Authenticator
  def initialize(administrator)
    @administrator = administrator
  end

  def authenticate(raw_password)
    @administrator &&
      @administrator.hashed_password &&
      # "=="は比較演算子ではなく、BCrypt::Passwordオブジェクトのインスタンスメソッド。引数に指定された平文のパスワードをハッシュ関数で計算し、自分自身の保持ているハッシュ値と同じであればTrueを返す。
      BCrypt::Password.new(@administrator.hashed_password) == raw_password
  end
end
