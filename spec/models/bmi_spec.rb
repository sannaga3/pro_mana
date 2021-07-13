require 'rails_helper'

RSpec.describe Bmi, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let(:bmi) { FactoryBot.build(:bmi, user: user) }
  let!(:second_bmi) { FactoryBot.build(:second_bmi, user: user) }
  describe 'Bmi作成時のバリデーションテスト' do
    context '身長、体重、日付が正しい場合' do
      it 'Bmiを作成できる' do
        expect(bmi).to be_valid
      end
    end
    context '身長が未入力の場合' do
      it 'バリデーションエラーになる' do
        bmi.height = nil
        expect(bmi).to be_invalid
      end
    end
    context '体重が未入力の場合' do
      it 'バリデーションエラーになる' do
        bmi.weight = nil
        expect(bmi).to be_invalid
      end
    end
    context '重複した日付で登録しようとした場合' do
      it 'バリデーションエラーになる' do
        new_bmi = Bmi.new(
          height: 160,
          weight: 55.5,
          record_on: "2021-07-02"
        )
        expect(new_bmi).to be_invalid
      end
    end
  end
end
