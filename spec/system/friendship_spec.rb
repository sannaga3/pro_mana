require 'rails_helper'

RSpec.describe Friendship, type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:third_user) { FactoryBot.create(:third_user) }
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
      expect(current_path).to eq nutrition_records_path
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
        sleep(0.5)
        has_selector?('#follow0')
        find('#follow0').click
        click_button 'フォロー'
        has_no_selector?('#follow0')
        has_selector?('#unfollow0')
      end
    end
    context '別ユーザーのプロフィールページでフォロー解除ボタンを押した場合,' do
      it 'フォローが解除される' do
        Friendship.create(
          follower_id: user.id,
          followed_id: third_user.id
        )
        visit user_path(third_user.id)
        expect(current_path).to eq user_path(third_user.id)
        expect(page).to have_content 'プロフィール'
        has_selector?('#unfollow0')
        find('#unfollow0').click
        sleep(0.5)
        has_no_selector?('#unfollow0')
        has_selector?('#follow0')
      end
    end
    context 'フォロー一覧ページから解除ボタンを押し、その後フォローボタンを押した場合,' do
      it 'フォローが解除され、その後再度フォローされる' do
        Friendship.create(
          follower_id: user.id,
          followed_id: third_user.id
        )
        visit users_path
        expect(current_path).to eq users_path
        expect(page).to have_content 'フォロー一覧'
        has_selector?('#unfollow0')
        find('#unfollow0').click
        sleep(0.5)
        has_no_selector?('#unfollow0')
        has_selector?('#follow0')
        find('#follow0').click
        sleep(0.5)
        has_no_selector?('#follow0')
        has_selector?('#unfollow0')
      end
    end
  end
end
