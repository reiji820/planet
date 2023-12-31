require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'varidation' do
    # 全部入力
    it 'is valid with all attributes' do
      post = create(:post)
      expect(post).to be_valid
      expect(post.errors).to be_empty
    end

    # タイトルなし
    it 'is invalid without title' do
      post_without_title = build(:post, title: '')
      expect(post_without_title).to be_invalid
      expect(post_without_title.errors.full_messages).to eq ['タイトルを入力してください']
    end

    # タイトルが230文字より多い
    it 'is invalid title longer than 230 characters' do
      post_with_longer_title = build(:post, title: 'a' * 231)
      expect(post_with_longer_title).to be_invalid
      expect(post_with_longer_title.errors.full_messages).to eq ['タイトルは230文字以内で入力してください']
    end

    # 開始時刻なし
    it 'is invalid without start_time' do
      post_without_start_time = build(:post, start_time: '')
      expect(post_without_start_time).to be_invalid
      expect(post_without_start_time.errors.full_messages).to eq ['開始時刻を入力してください']
    end

    #  終了時刻なし
    it 'is invalid without end_time' do
      post_without_end_time = build(:post, end_time: '')
      expect(post_without_end_time).to be_invalid
      expect(post_without_end_time.errors.full_messages).to eq ['終了時刻を入力してください']
    end

    # 予算なし
    it 'is invalid without budget' do
      post_without_budget = build(:post, budget: '')
      expect(post_without_budget).to be_invalid
      expect(post_without_budget.errors.full_messages).to eq ['予算を入力してください']
    end

    # 都道府県なし
    it 'is invalid without prefecture_id' do
      post_without_budget = build(:post, prefecture_id: '')
      expect(post_without_budget).to be_invalid
      expect(post_without_budget.errors.full_messages).to eq ['都道府県を選択してください']
    end
  end
end