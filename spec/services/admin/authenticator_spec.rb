require 'spec_helper'

describe Admin::Authenticator do
  describe '#authenticate' do
    example '正しいパスワードならTrueを返す' do
      m = FactoryGirl.build(:administrator)   #Added 'FactoryGirl.'
      expect(Admin::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    example '誤ったパスワードならFalseを返す' do
      m = FactoryGirl.build(:administrator)
      expect(Admin::Authenticator.new(m).authenticate('xy')).to be_falsey
    end

    example 'パスワード未設定ならFaslseを返す' do
      m = FactoryGirl.build(:administrator, password: nil)
      expect(Admin::Authenticator.new(m).authenticate(nil)).to be_falsey
    end

    example '停止フラグが立っていればTrueを返す' do
      m = FactoryGirl.build(:administrator, suspended: true)
      expect(Admin::Authenticator.new(m).authenticate('pw')).to be_truthy
    end
  end
end
#should be suspended - fixed
