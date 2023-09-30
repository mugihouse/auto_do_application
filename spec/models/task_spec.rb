require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { create(:task) }

  describe '正常系テスト' do
    context '全て正常な場合' do
      it '保存できる' do
        expect(task).to be_valid
      end
    end
  end

  describe '異常系テスト' do
    context 'title' do
      it '空の場合、保存できない' do
        task[:title] = nil
        task.valid?
        expect(task.errors.full_messages).to include('タイトルを入力してください')
      end
    end

    context 'time_required' do
      it '空の場合、保存できない' do
        task[:time_required] = nil
        task.valid?
        expect(task.errors.full_messages).to include('所要時間を入力してください')
      end
    end

    context 'user_id' do
      it '空の場合、保存できない' do
        task[:user_id] = nil
        task.valid?
        expect(task.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
