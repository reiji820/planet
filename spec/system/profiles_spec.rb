require 'rails_helper'

RSpec.describe "Profiles", type: :system do
  let(:user) { create(:user) }
  let(:user_post) { create(:post, user: user) }
  let(:other_user) { create(:user) }
  let!(:favorite_post) { create(:post, user: other_user, title: "他のユーザーの投稿") }

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
        select '大阪府', from: 'user_residence'
        fill_in 'user[hobbies]', with: 'ゲーム'
        fill_in 'user[self_introduction]', with: 'インドア派'
        click_on '更新'
        expect(page).to have_content('プロフィールを更新しました')
        expect(find_field('user[name]').value).to eq 'update'
        expect(find_field('user[residence]').value).to eq '大阪府'
        expect(find_field('user[hobbies]').value).to eq 'ゲーム'
        expect(find_field('user[self_introduction]').value).to eq 'インドア派'
        expect(current_path).to eq edit_profile_path
      end
    end
  end

  describe '自分の投稿確認' do
    it '自分の投稿確認できる' do
      user_post
      expect(current_path).to eq profile_path
      click_on '自分の投稿'
      expect(page).to have_content(user_post.title)
    end
  end

  describe 'いいね一覧確認' do
  
    before do
      # ユーザーが他のユーザーの投稿を「いいね」する
      user.favorites.create(post: favorite_post)
    end
  
    it 'いいね一覧を確認できる' do
      click_on 'いいね一覧'
      expect(page).to have_content('いいねした投稿')
  
      # ユーザーがいいねした投稿が表示されているか確認
      expect(page).to have_content(favorite_post.title)
    end
  end
end