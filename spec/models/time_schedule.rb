require 'rails_helper'

RSpec.describe TimeSchedule, type: :model do
  describe 'varidation' do
    # 全部入力
    it 'is valid with all attributes' do
      time_schedule = create(:time_schedule)
      expect(time_schedule).to be_valid
      expect(time_schedule.errors).to be_empty
    end

    # 時刻なし
    it 'is invalid without time_stamp' do
      time_schedule_without_time_stamp = build(:time_schedule, time_stamp: '')
      expect(time_schedule_without_time_stamp).to be_invalid
      expect(time_schedule_without_time_stamp.errors.full_messages).to eq ['時刻を入力してください']
    end

    # 予定なし
    it 'is invalid without plan' do
      time_schedule_without_plan = build(:time_schedule, plan: '')
      expect(time_schedule_without_plan).to be_invalid
      expect(time_schedule_without_plan.errors.full_messages).to eq ['予定を入力してください']
    end
  end
end