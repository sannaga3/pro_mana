require 'rails_helper'

RSpec.describe NutritionRecord, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:food) { FactoryBot.create(:food, user: user) }
  let!(:fourth_food) { FactoryBot.create(:fourth_food, user: user) }
  let(:record) { FactoryBot.build(:record, user: user) }
  let!(:sixth_record) { FactoryBot.create(:sixth_record, user: user) }
  describe '食品記録作成時のバリデーションテスト' do
    context '日付が重複しておらず、食品が選択されており食事量が入力されている場合' do
      it '記録を作成できる' do
        expect(record).to be_valid
      end
    end
    context '日付が重複している場合' do
      it 'バリデーションエラーになる' do
        new_record = NutritionRecord.new(start_time: '2021-06-06', user: user)
        expect(new_record).to be_invalid
      end
    end
    context '食品が未選択の場合' do
      it 'バリデーションエラーになる' do
        record.nutrition_record_lines[0].food_id = nil
        expect(record).to be_invalid
      end
    end
    context '食事量が未入力の場合' do
      it 'バリデーションエラーになる' do
        record.nutrition_record_lines[0].ate = nil
        expect(record.nutrition_record_lines[0]).to be_invalid
      end
    end
  end
end