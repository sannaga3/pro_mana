require 'rails_helper'

RSpec.describe Record, type: :model do
  let!(:first_user) { FactoryBot.create(:first_user)}
  let!(:first_food) { FactoryBot.create(:first_food) }
  let(:record) { FactoryBot.create(:record)}
  describe '食品記録作成時のバリデーションテスト' do
    context '食事量と日付が正しい場合' do
      it '記録を作成できる' do
        expect(record).to be_valid
      end
    end
    context '食事量が未入力の場合' do
      it 'バリデーションエラーになる' do
        record.ate = nil
        expect(record).to be_invalid
      end
    end
  end
end
