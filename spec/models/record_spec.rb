require 'rails_helper'

RSpec.describe Record, type: :model do
  let!(:user_one) { FactoryBot.create(:user_one)}
  let!(:food_one) { FactoryBot.create(:food_one) }
  let(:record_one) { FactoryBot.create(:record_one)}
  describe '食品記録作成時のバリデーションテスト' do
    context '食事量と日付が正しい場合' do
      it '記録を作成できる' do
        expect(record_one).to be_valid
      end
    end
    context '食事量が未入力の場合' do
      it 'バリデーションエラーになる' do
        record_one.ate = nil
        expect(record_one).to be_invalid
      end
    end
  end
end
