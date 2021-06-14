require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:food) { FactoryBot.create(:food)}
  describe '食品新規作成時のバリデーションテスト' do
    context '名前、タンパク質量、量、単位、が正しい場合' do
      it '食品を作成できる' do
        expect(food).to be_valid
      end
    end
    context '食品名が未入力の場合' do
      it 'バリデーションエラーになる' do
        food.name = nil
        expect(food).to be_invalid
      end
    end
    context '食品名が51文字以上の場合' do
      it 'バリデーションエラーになる' do
        food.name = "納豆"*26
        expect(food).to be_invalid
      end
    end
    context 'タンパク質量が未入力の場合' do
      it 'バリデーションエラーになる' do
        food.protein = ""
        expect(food).to be_invalid
      end
    end
    context '量が未入力の場合' do
      it 'バリデーションエラーになる' do
        food.quantity = ""
        expect(food).to be_invalid
      end
    end
    context '単位が未入力の場合' do
      it 'バリデーションエラーになる' do
        food.unit = ""
        expect(food).to be_invalid
      end
    end
    context '単位が11文字以上の場合' do
      it 'バリデーションエラーになる' do
        food.unit = "個"*11
        expect(food).to be_invalid
      end
    end
  end
end
