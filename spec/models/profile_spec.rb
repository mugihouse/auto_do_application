require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:profile) { create(:profile) }
  describe '正常系テスト' do
    context '全て正常な場合' do
      it '保存できる' do
        expect(profile).to be_valid
      end
    end
  end

  describe '異常系テスト' do
    context 'user_idがnil' do
      it '保存できない' do
        profile[:user_id] = nil
        profile.valid?
        expect(profile.errors.full_messages).to include('Userを入力してください')
      end
    end

    context 'notification_settingがnil' do
      it '保存できない' do
        profile[:notification_setting] = nil
        profile.valid?
        expect(profile.errors.full_messages).to include('配信設定を入力してください')
      end
    end
  end
end
