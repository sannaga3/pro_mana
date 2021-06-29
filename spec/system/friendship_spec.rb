require 'rails_helper'

RSpec.describe Friendship, type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:third_user) { FactoryBot.create(:third_user) }
  let!(:fourth_user) { FactoryBot.create(:fourth_user) }
  let!(:fourth_food) { FactoryBot.create(:fourth_food, user: third_user) }
  let!(:fifth_record) { FactoryBot.create(:fifth_record, user: third_user) }
  describe 'フォロー機能' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: 'machigaisagasi@example.com'
      fill_in 'user[password]', with: 'sayonaraerezi'
      click_button 'ログイン'
      expect(current_path).to eq user_path(user.id)
      expect(page).to have_content 'ログインしました。'
      expect(page).to have_content 'すだまさき'
      click_on 'みんなの記録'
      expect(current_path).to eq records_path
      expect(page).to have_content 'みんなの記録'
    end
    context '別ユーザーのプロフィールページでフォローボタンを押した場合,' do
      it 'フォローできる' do
        expect(page).to have_content '鳥もも肉'
        table_days = all('.table_date')
        expect(table_days.count).to eq 1
        table_user_names = all('.table_user_name')
        expect(table_user_names.count).to eq 1
        find('.table_user_name').click
        expect(current_path).to eq user_path(third_user.id)
        expect(page).to have_content 'プロフィール'
        follow_button = all('#follow')
        expect(follow_button.count).to eq 1
        find('#follow').click
        expect(current_path).to eq user_path(third_user.id)
        unfollow_button = all('#unfollow')
        expect(1).to eq unfollow_button.count
        follow_button = all('#follow')
        expect(0).to eq follow_button.count
      end
    end
    context '別ユーザーのプロフィールページでフォロー解除ボタンを押した場合,' do
      it 'フォローが解除される' do
        Friendship.create(
          follower_id: user.id,
          followed_id: fourth_user.id
        )
        visit user_path(fourth_user.id)
        expect(current_path).to eq user_path(fourth_user.id)
        expect(page).to have_content 'プロフィール'
        unfollow_button = all('#unfollow')
        expect(unfollow_button.count).to eq 1
        find('#unfollow').click
        sleep(0.5)
        expect(current_path).to eq user_path(fourth_user.id)
        unfollow_button = all('#unfollow')
        expect(unfollow_button.count).to eq 0
        follow_button = all('#follow')
        expect(follow_button.count).to eq 1
      end
    end
  end
end
