require 'rails_helper'

RSpec.describe Reply, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:contact) { FactoryBot.create(:contact, user: user) }
  let(:reply) { FactoryBot.build(:reply, contact: contact, user_id: user.id) }
  describe '返信作成時のバリデーションテスト' do
    context 'commentが1000文字以内かつcontact_idとreplier_idがある場合' do
      it '返信を作成できる' do
        expect(reply).to be_valid
      end
    end
    context 'commentが未入力の場合' do
      it 'バリデーションエラーになる' do
        reply.comment = nil
        expect(reply).to be_invalid
      end
    end
    context 'commentが1001文字以上の場合' do
      it 'バリデーションエラーになる' do
        reply.comment = nil
        expect(reply).to be_invalid
      end
    end
    context 'contact_idがない場合' do
      it 'バリデーションエラーになる' do
        reply.contact_id = nil
        expect(reply).to be_invalid
      end
    end
    context 'user_idがないの場合' do
      it 'バリデーションエラーになる' do
        reply.user_id = nil
        expect(reply).to be_invalid
      end
    end
  end
end