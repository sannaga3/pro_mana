require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:third_user) { FactoryBot.create(:third_user) }
  let(:friendship) { user.active_friendships.build(followed_id: third_user.id) }
  describe 'フォロー機能' do
    context 'follower_idとfollowed_idがある場合' do
      it 'フォローする' do
        expect(friendship).to be_valid
      end
    end
    context 'follower_idがない場合,' do
      it 'バリデーションエラーになる' do
        user = FactoryBot.create(:user)
        friendship = Friendship.new(
          follower_id: nil,
          followed_id: user.id
        )
        friendship.valid?
      end
    end
    context 'followed_idがない場合,' do
      it 'バリデーションエラーになる' do
        user = FactoryBot.create(:user)
        friendship = Friendship.new(
          follower_id: nil,
          followed_id: user.id
        )
        friendship.valid?
      end
    end
    context 'follower_idとfollowed_idがない場合,' do
      it 'バリデーションエラーになる' do
        friendship = Friendship.new(
          follower_id: nil,
          followed_id: nil
        )
        friendship.valid?
      end
    end
  end
end
