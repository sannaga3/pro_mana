require 'rails_helper'

RSpec.describe Contact, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let(:contact) { FactoryBot.build(:contact, user: user) }
  describe 'お問合せ作成時のバリデーションテスト' do
    context 'titleが100文字以内かつcontentが1000文字以内の場合' do
      it 'お問合せを作成できる' do
        expect(contact).to be_valid
      end
    end
    context 'titleが未入力の場合' do
      it 'バリデーションエラーになる' do
        contact.title = nil
        expect(contact).to be_invalid
      end
    end
    context 'contentが未入力の場合' do
      it 'バリデーションエラーになる' do
        contact.content = nil
        expect(contact).to be_invalid
      end
    end
    context 'titleが100文字以上の場合' do
      it 'バリデーションエラーになる' do
        contact.title = "チョヒャド" * 30
        expect(contact).to be_invalid
      end
    end
    context 'contentが1000文字以上の場合' do
      it 'バリデーションエラーになる' do
        contact.title = "プラズマクラスターー！" * 100
        expect(contact).to be_invalid
      end
    end
  end
end
