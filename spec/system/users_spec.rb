require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    describe 'ユーザーの新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規登録が成功する' do
          visit new_user_path
          fill_in 'user[name]', with: 'test'
          fill_in 'user[email]', with: 'test@example.com'
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_button '登録'
          expect(page).to have_content('投稿を検索')
          expect(current_path).to eq root_path
        end
      end

      context 'ユーザー名が未入力' do
        it 'ユーザーの新規登録が失敗する' do
          visit new_user_path
          fill_in 'user[name]', with: ''
          fill_in 'user[email]', with: 'test@example.com'
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_button '登録'
          expect(page).to have_content('ユーザー名を入力してください')
          expect(current_path).to eq users_path
        end
      end

      context 'ユーザー名が15文字より多い' do
        it 'ユーザーの新規登録が失敗する' do
          visit new_user_path
          fill_in 'user[name]', with: 'あいうえおかきくけこさしすせそたちつてと'
          fill_in 'user[email]', with: 'test@example.com'
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_button '登録'
          expect(page).to have_content('ユーザー名は15文字以内で入力してください')
          expect(current_path).to eq users_path
        end
      end

      context 'メールアドレスが未入力' do
        it 'ユーザーの新規登録が失敗する' do
          visit new_user_path
          fill_in 'user[name]', with: 'test'
          fill_in 'user[email]', with: ''
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_button '登録'
          expect(page).to have_content('メールアドレスを入力してください')
          expect(current_path).to eq users_path
        end
      end

      context '登録済みのメールアドレスを使用' do
        it 'ユーザーの新規登録が失敗する' do
          existed_user = create(:user)
          visit new_user_path
          fill_in 'user[name]', with: 'test'
          fill_in 'user[email]', with: existed_user.email
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_button '登録'
          expect(page).to have_content('メールアドレスはすでに存在します')
          expect(current_path).to eq users_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before do
      login(user)
      expect(page).to have_content('投稿を検索')
      visit edit_profile_path
    end

    describe 'プロフィール編集' do
      context 'フォームの入力が正常' do
        it 'プロフィールの編集が成功する' do
          fill_in 'user[name]', with: 'update'
          fill_in 'user[place_of_birth]', with: '大阪'
          fill_in 'user[hobbies]', with: 'ゲーム'
          fill_in 'user[self_introduction]', with: 'インドアです'
          click_on '更新'
          expect(find_field('user[name]').value).to eq 'update'
          expect(find_field('user[place_of_birth]').value).to eq '大阪'
          expect(find_field('user[hobbies]').value).to eq 'ゲーム'
          expect(find_field('user[self_introduction]').value).to eq 'インドアです'
          expect(current_path).to eq edit_profile_path
        end
      end

      context 'ニックネームが未入力' do
        it 'プロフィールの編集が失敗する' do
          fill_in 'user[name]', with: ''
          fill_in 'user[place_of_birth]', with: '大阪'
          fill_in 'user[hobbies]', with: 'ゲーム'
          fill_in 'user[self_introduction]', with: 'インドアです'
          click_on '更新'
          expect(page).to have_content('ユーザー名を入力してください')
        end
      end

      context 'ニックネームが15文字より多い' do
        it 'プロフィールの編集が失敗する' do
          fill_in 'user[name]', with: 'あいうえおかきくけこさしすせそたちつてと'
          fill_in 'user[place_of_birth]', with: '大阪'
          fill_in 'user[hobbies]', with: 'ゲーム'
          fill_in 'user[self_introduction]', with: 'インドアです'
          click_on '更新'
          expect(page).to have_content('ユーザー名は15文字以内で入力してください')
        end
      end
    end
  end
end
