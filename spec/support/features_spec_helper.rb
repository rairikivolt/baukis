module FeaturesSpecHelper
  def switch_namespace(namespace)
    config = Rails.application.config.baukis
    Capybara.app_host = 'http://' + config[namespace][:host]
  end

  def login_as_staff_member(staff_member, password = 'pw')
    visit staff_login_path #can be written: visit '/login'
    within('#login-form') do
      fill_in 'メールアドレス', with: staff_member.email
      #can be written: fill_in 'staff_login_form_email', with: staff_member.email #id属性を指定
      #can be written: fill_in 'staff_login_form[email]', with: staff_member.email #name属性を指定
      fill_in 'パスワード', with: password
      click_button 'ログイン'
    end
  end
end
