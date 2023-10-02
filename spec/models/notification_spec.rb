require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:notification) { create(:notification) }

  describe '正常系テスト' do
    context '全て正常な場合' do
      it '保存できる' do
        expect(notification).to be_valid
      end
    end
  end

  describe '異常系テスト' do
    context 'statusがnil' do
      it '保存できない' do
        notification[:status] = nil
        notification.valid?
        expect(notification.errors.full_messages).to include('Statusを入力してください')
      end
    end

    context 'task_idがnil' do
      it '保存できない' do
        notification[:task_id] = nil
        notification.valid?
        expect(notification.errors.full_messages).to include('Taskを入力してください')
      end
    end

    context 'user_idがnil' do
      it '保存できない' do
        notification[:user_id] = nil
        notification.valid?
        expect(notification.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
