require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let(:task) { create(:task) }

  describe 'Task#index' do
    before do
      login(task)
      visit tasks_path
    end
    context '正常系' do
      it '一覧ページにアクセスすると、タスクが表示される' do
        expect(page).to have_content task.title
        expect(Task.count).to eq 1
      end
    end
  end

  describe 'Task#new' do
    before do
      login(task)
      visit new_task_path
    end
    context '全て入力されている' do
      it 'タスクが保存される' do
        fill_in 'タイトル', with: 'test_title2'
        fill_in '内容', with: 'test_body2'
        choose '短い'
        click_button '登録'
        expect(page).to have_content('タスクを登録しました')
        expect(Task.count).to eq 2
        expect(current_path).to eq '/tasks/2'
      end
    end

    context 'タイトルが未入力' do
      it 'タスクが保存されない' do
        fill_in '内容', with: 'test_body2'
        choose '短い'
        click_button '登録'
        expect(page).to have_content('タスクの作成に失敗しました')
        expect(page).to have_content('タイトルを入力してください')
      end
    end

    context '所要時間が未入力' do
      it 'タスクが保存されない' do
        fill_in 'タイトル', with: 'test_title2'
        fill_in '内容', with: 'test_body2'
        click_button '登録'
        expect(page).to have_content('タスクの作成に失敗しました')
        expect(page).to have_content('所要時間を入力してください')
      end
    end
  end

  describe 'Task#change_status' do
    before do
      login(task)
      visit task_path(task)
    end
    context  '削除ボタンを押す' do
      it 'タスクのstatusがfinishに変わる' do
        click_link '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content('タスクを削除しました')
        expect(page).not_to have_content task.title
        expect(Task.count).to eq 1
        expect(current_path).to eq tasks_path
      end
    end
  end
end
