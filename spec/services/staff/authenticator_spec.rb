require 'spec_helper'

describe Staff::Authenticator do
  describe '#authenticate' do
    example '正しいパスワードならTrueを返す' do
      m = FactoryGirl.build(:staff_member)   #Added 'FactoryGirl.'
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    example '誤ったパスワードならFalseを返す' do
      m = FactoryGirl.build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate('xy')).to be_falsey
    end

    example 'パスワード未設定ならFaslseを返す' do
      m = FactoryGirl.build(:staff_member, password: nil)
      expect(Staff::Authenticator.new(m).authenticate(nil)).to be_falsey
    end

    example '停止フラグが立っていればTrueを返す' do
      m = FactoryGirl.build(:staff_member, suspended: true)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    example '開始前ならFaslseを返す' do
      m = FactoryGirl.build(:staff_member, start_date: Date.tomorrow)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end

    example '終了後ならFaslseを返す' do
      m = FactoryGirl.build(:staff_member, end_date: Date.today)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end
  end
end
