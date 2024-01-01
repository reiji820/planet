require 'rails_helper'

RSpec.describe "Profiles", type: :system do
  let(:user) { create(:user) }

  before do
    login(user)
    visit profile_path
  end
  describe 'ページ遷移確認' do
    it 'ページ遷移できる' do
      visit root_path
      click_on 'マイページ'
      expect(current_path).to eq profile_path
    end
  end

  describe 'プロフィール編集' do
    context 'フォームの入力値が正常' do
      it 'プロフィール編集できる' do
        click_on '編集'
        fill_in 'user[name]', with: 'update'
        fill_in 'user[place_of_birth]', with: '大阪'
        fill_in 'user[hobbies]', with: 'ゲーム'
        fill_in 'user[self_introduction]', with: 'インドア派'
        click_on '更新'
        expect(page).to have_content('プロフィールを更新しました')
        expect(find_field('user[name]').value).to eq 'update'
        expect(find_field('user[place_of_birth]').value).to eq '大阪'
        expect(find_field('user[hobbies]').value).to eq 'ゲーム'
        expect(find_field('user[self_introduction]').value).to eq 'インドア派'
        expect(current_path).to eq edit_profile_path
      end
    end
  end
end