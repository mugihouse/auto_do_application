require 'rails_helper'

RSpec.describe "Profiles", type: :system do
  let(:profile) { create(:profile) }

  before do
    login(profile)
  end
  describe 'Profile#new' do
    context '正常系' do
      it 'プロフィールを新規作成できる' do
        visit new_profile_path
        select_time('19', '00', from: '夕ご飯の時間')
        select_time('23', '00', from: '就寝時間')
        click_button '登録'
        expect(page).to have_content 'プロフィールを登録しました'
        expect(Profile.count).to eq 1
        expect(current_path).to eq '/profile.1'
      end
    end
  end

  describe 'Profile#edit' do
    context '正常系' do
      it 'プロフィールを編集できる' do
        visit edit_profile_path
        select_time('20', '00', from: '夕ご飯の時間')
        select_time('00', '00', from: '就寝時間')
        click_button '登録'
        expect(page).to have_content 'プロフィールを更新しました'
        expect(Profile.count).to eq 1
        expect(current_path).to eq '/profile.1'
      end
    end
  end

  describe 'Profile#show' do
    context '正常系' do
      it 'プロフィールが表示される' do
        visit profile_path
        expect(page).to have_content(profile.dinner_time.strftime("%H:%M"))
        expect(page).to have_content(profile.bedtime.strftime("%H:%M"))
      end
    end
  end
end
