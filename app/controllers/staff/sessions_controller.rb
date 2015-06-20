class Staff::SessionsController < Staff::Base
  skip_before_action :authorize

  def new
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render action: 'new'
    end
  end
#ここに半角のスペースがあった:0 OMG!
  def create
    #paramsオブジェクト params[:x]は一種のハッシュ（正確に言えばActionController::Parametersクラスのインスタンス)
    #例：
    #staff_login_form{
    #email:'hanako@example.com'
    #password: 'foobar' }
    #Staff::LoginFormは非Active Recordモデル。クラスメソッドにnewにハッシュを与えれば、その属性を持つインスタンスを作れる。
    @form = Staff::LoginForm.new(params[:staff_login_form])
    if @form.email.present?
      #ハッシュにemailがあれば、StaffMemberオブジェクトを検索
      staff_member = StaffMember.find_by(email_for_index: @form.email.downcase)
    end

    if Staff::Authenticator.new(staff_member).authenticate(@form.password) #authenticato.rbを作成し、'staff_member'から変更。ユーザー認証機能が追加されている
      if staff_member.suspended?
        flash.now.alert = "アカウントが停止されています。" #added .now since forgot
        render action: 'new'
      else
        session[:staff_member_id] = staff_member.id #session object, not session var, session_member_idをセットしてログインと分かる
        flash.notice = 'ログインしましたXD'
        redirect_to :staff_root
      end
    else
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません><'
      render action: 'new'
    end
  end

  def destroy
    session.delete(:staff_member_id)
    flash.notice = 'ログアウトしましたXD'
    redirect_to :staff_root
  end
end
