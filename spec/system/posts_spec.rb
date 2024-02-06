require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let(:post) { create(:post) }
  let(:user) { create(:user) }
  let(:user_post) { create(:post, user: user) }

  describe 'ログイン前' do
    before do
      post
      visit posts_path
    end
    describe 'ページ遷移確認' do
      it '投稿一覧ページに遷移できる' do
        expect(page).to have_content('投稿を検索')
        expect(current_path).to eq posts_path
      end

      it '投稿詳細ページに遷移できる' do
        click_link post.title
        expect(page).to have_content(post.title)
        expect(current_path).to eq post_path(post.id)
      end
    end
  end

  describe 'ログイン後' do
    before do
      login(user)
      user_post
      post
    end
    describe '投稿登録' do
      context 'フォームの入力値が正常' do
        it '投稿登録できる' do
          visit new_post_path
          fill_in 'post[title]', with: 'test'
          fill_in 'post[start_time]', with: 'Sat, 01 Jan 2000 00:00:00.000000000 JST +09:00'
          fill_in 'post[end_time]', with: 'Sat, 01 Jan 2000 12:00:00.000000000 JST +09:00'
          fill_in 'post[budget]', with: 'budget'
          attach_file('post[image]', "#{Rails.root}/spec/factories/test.png")
          select '青森県', from: 'post_prefecture_id'
          choose '春'
          click_on '投稿'
          expect(page).to have_content('Plan Details')
          expect(page).to have_content('test')
        end
      end

      context 'タイトル未入力' do
        it '投稿失敗する' do
          visit new_post_path
          fill_in 'post[title]', with: ''
          fill_in 'post[start_time]', with: 'Sat, 01 Jan 2000 00:00:00.000000000 JST +09:00'
          fill_in 'post[end_time]', with: 'Sat, 01 Jan 2000 12:00:00.000000000 JST +09:00'
          fill_in 'post[budget]', with: 'budget'
          attach_file('post[image]', "#{Rails.root}/spec/factories/test.png")
          select '青森県', from: 'post_prefecture_id'
          choose '春'
          click_on '投稿'
          expect(page).to have_content('タイトルを入力してください')
          expect(current_path).to eq posts_path
        end
      end

      context 'タイトルが230文字より多い' do
        it '投稿失敗する' do
          visit new_post_path
          fill_in 'post[title]', with: 'a' * 231
          fill_in 'post[start_time]', with: 'Sat, 01 Jan 2000 00:00:00.000000000 JST +09:00'
          fill_in 'post[end_time]', with: 'Sat, 01 Jan 2000 12:00:00.000000000 JST +09:00'
          fill_in 'post[budget]', with: 'budget'
          attach_file('post[image]', "#{Rails.root}/spec/factories/test.png")
          select '青森県', from: 'post_prefecture_id'
          choose '春'
          click_on '投稿'
          expect(page).to have_content('タイトルは230文字以内で入力してください')
          expect(current_path).to eq posts_path
        end
      end

      context '開始時刻未入力' do
        it '投稿失敗する' do
          visit new_post_path
          fill_in 'post[title]', with: 'test'
          fill_in 'post[start_time]', with: ''
          fill_in 'post[end_time]', with: 'Sat, 01 Jan 2000 12:00:00.000000000 JST +09:00'
          fill_in 'post[budget]', with: 'budget'
          attach_file('post[image]', "#{Rails.root}/spec/factories/test.png")
          select '青森県', from: 'post_prefecture_id'
          choose '春'
          click_on '投稿'
          expect(page).to have_content('開始時刻を入力してください')
          expect(current_path).to eq posts_path
        end
      end

      context '終了時刻未入力' do
        it '投稿失敗する' do
          visit new_post_path
          fill_in 'post[title]', with: 'test'
          fill_in 'post[start_time]', with: 'Sat, 01 Jan 2000 00:00:00.000000000 JST +09:00'
          fill_in 'post[end_time]', with: ''
          fill_in 'post[budget]', with: 'budget'
          attach_file('post[image]', "#{Rails.root}/spec/factories/test.png")
          select '青森県', from: 'post_prefecture_id'
          choose '春'
          click_on '投稿'
          expect(page).to have_content('終了時刻を入力してください')
          expect(current_path).to eq posts_path
        end
      end

      context '予算未入力' do
        it '投稿失敗する' do
          visit new_post_path
          fill_in 'post[title]', with: 'test'
          fill_in 'post[start_time]', with: 'Sat, 01 Jan 2000 00:00:00.000000000 JST +09:00'
          fill_in 'post[end_time]', with: 'Sat, 01 Jan 2000 12:00:00.000000000 JST +09:00'
          fill_in 'post[budget]', with: ''
          attach_file('post[image]', "#{Rails.root}/spec/factories/test.png")
          select '青森県', from: 'post_prefecture_id'
          choose '春'
          click_on '投稿'
          expect(page).to have_content('予算を入力してください')
          expect(current_path).to eq posts_path
        end
      end

      context '都道府県未選択' do
        it '投稿失敗する' do
          visit new_post_path
          fill_in 'post[title]', with: 'test'
          fill_in 'post[start_time]', with: 'Sat, 01 Jan 2000 00:00:00.000000000 JST +09:00'
          fill_in 'post[end_time]', with: 'Sat, 01 Jan 2000 12:00:00.000000000 JST +09:00'
          fill_in 'post[budget]', with: 'budget'
          attach_file('post[image]', "#{Rails.root}/spec/factories/test.png")
          choose '春'
          click_on '投稿'
          expect(page).to have_content('都道府県を選択してください')
          expect(current_path).to eq posts_path
        end
      end
    end

    describe '投稿編集' do
      context 'フォームの入力値が正常' do
        it '投稿編集できる' do
          visit post_path(user_post)
          click_on '編集'
          expect(page).to have_content('投稿編集')
          fill_in 'post[title]', with: 'update'
          fill_in 'post[start_time]', with: 'Sat, 01 Jan 2000 03:00:00.000000000 JST +09:00'
          fill_in 'post[end_time]', with: 'Sat, 01 Jan 2000 15:00:00.000000000 JST +09:00'
          fill_in 'post[budget]', with: 'edit'
          select '大阪府', from: 'post_prefecture_id'
          choose '夏'
          click_on '更新'
          expect(page).to have_content('編集を更新しました')
          expect(find_field('post[title]').value).to eq 'update'
          expect(find_field('post[start_time]').value).to eq '03:00:00.000'
          expect(find_field('post[end_time]').value).to eq '15:00:00.000'
          expect(find_field('post[budget]').value).to eq 'edit'
          expect(find_field('post[prefecture_id]').value).to eq '27'
          expect(current_path).to eq edit_post_path(user_post)
        end
      end

      context '編集する投稿が自分のものではない' do
        it '投稿編集画面に遷移できない' do
          post
          visit post_path(post)
          expect(page).not_to have_content('編集')
        end
      end
    end

    describe '投稿削除' do
      context '削除する投稿が自分のもの' do
        it '投稿削除できる' do
          visit post_path(user_post)
          click_on '削除'
          expect {
            page.accept_confirm "削除しますか？"
            expect(page).to have_content "投稿を検索"
          }
        end
      end

      context '削除する投稿が自分のものではない' do
        it '投稿削除できない' do
          visit post_path(post)
          expect(page).not_to have_content('削除')
        end
      end
    end

    describe '投稿検索' do
      context '検索結果が存在する' do
        it '検索結果一覧に遷移する' do
          visit root_path
          fill_in 'keyword', with: post.title
          find('#search').click
          expect(page).to have_content(post.title)
        end
      end

      context '検索結果が存在しない' do
        it '検索結果一覧に遷移しない' do
          visit root_path
          fill_in 'keyword', with: 'abcdefghijk'
          find('#search').click
          expect(page).not_to have_content('abcdefghijk')
        end
      end
    end

    describe '都道府県検索' do
      context '検索結果が存在する' do
        it '検索結果一覧に遷移する' do
          visit root_path
          select '北海道', from: 'prefecture_id'
          find('#search').click
          expect(page).to have_content(post.title)
        end
      end

      context '検索結果が存在しない' do
        it '検索結果一覧に遷移しない' do
          visit root_path
          select '大阪府', from: 'prefecture_id'
          find('#search').click
          expect(page).not_to have_content(post.title)
        end
      end
    end

    describe '季節検索' do
      context '検索結果が存在する' do
        it '検索結果一覧に遷移する' do
          visit root_path
          select '春', from: 'season'
          find('#search').click
          expect(page).to have_content(post.title)
        end
      end

      context '検索結果が存在しない' do
        it '検索結果一覧に遷移しない' do
          visit root_path
          select '夏', from: 'season'
          find('#search').click
          expect(page).not_to have_content(post.title)
        end
      end
    end
  end
end