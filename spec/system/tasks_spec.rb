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

  describe 'Task#show' do
    before do
      login(task)
      visit task_path(task)
    end
    context '正常系' do
      it 'タスクが表示される' do
        visit task_path(task)
        expect(page).to have_content(task.title)
        expect(page).to have_content(task.body)
        expect(page).to have_content(task.time_required_i18n)
      end
    end
  end

  describe 'Task#edit' do
    before do
        login(task)
        visit edit_task_path(task)
    end
    context '正常系' do
      it 'タスクを編集すると、詳細画面に編集後の内容が表示される' do
        fill_in 'タイトル', with: 'edit_test_title'
        fill_in '内容', with: 'edit_test_body'
        choose 'かなり長い'
        click_button '登録'
        expect(page).to have_content('edit_test_title')
        expect(page).to have_content('edit_test_body')
        expect(page).to have_content('かなり長い')
        expect(current_path).to eq task_path(task)
      end
    end

    context 'タイトルを空白にする' do
      it 'タスクの編集が失敗する' do
        fill_in 'タイトル', with: ''
        click_button '登録'
        expect(page).to have_content('タスクの更新に失敗しました')
        expect(page).to have_content('タイトルを入力してください')
      end
    end
  end

  describe 'Task#change_status' do
    before do
      login(task)
      visit task_path(task)
    end
    context '削除ボタンを押す' do
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
