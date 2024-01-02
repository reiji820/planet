require 'rails_helper'

RSpec.describe "TimeSchedules", type: :system do
  let(:user) { create(:user) }
  let(:user_post) { create(:post, user: user) }
  let(:time_schedule) { create(:time_schedule) }

  before do
    login(user)
    user_post
    visit post_path(user_post)
  end
  describe 'スケジュール登録' do
    context 'フォームの入力値が正常' do
      it 'スケジュール登録できる' do
        fill_in 'time_schedule[time_stamp]', with: 'Sat, 01 Jan 2000 00:00:00.000000000 JST +09:00'
        fill_in 'time_schedule[plan]', with: 'test'
        click_on '追加'
        expect(page).to have_content('00:00')
        expect(page).to have_content('test')
      end

      it '時刻未入力' do
        fill_in 'time_schedule[time_stamp]', with: ''
        fill_in 'time_schedule[plan]', with: 'test'
        click_on '追加'
        expect(page).to have_content('時刻を入力してください')
      end

      it '予定未入力' do
        fill_in 'time_schedule[time_stamp]', with: 'Sat, 01 Jan 2000 00:00:00.000000000 JST +09:00'
        fill_in 'time_schedule[plan]', with: ''
        click_on '追加'
        expect(page).to have_content('予定を入力してください')
      end
    end

    describe 'スケジュール削除' do
      context 'スケジュールが自分のもの' do
        it 'スケジュールを削除できる' do
          fill_in 'time_schedule[time_stamp]', with: 'Sat, 01 Jan 2000 00:00:00.000000000 JST +09:00'
          fill_in 'time_schedule[plan]', with: 'test'
          expect(page).to have_content('00:00')
          click_on '削除'
          expect {
            page.accept_confirm "削除しますか？"
            expect(page).to have_content "Plan Schedule"
          }
          expect(page).not_to have_content('00:00')
          expect(page).not_to have_content('test')
        end
      end
    end
  end
end