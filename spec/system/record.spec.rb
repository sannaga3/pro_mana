require 'rails_helper'
describe '食品記録機能', type: :system do
  describe '新規記録作成テスト' do
    let!(:user) { FactoryBot.create(:user)}
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: 'machigaisagasi@example.com'
      fill_in 'user[password]', with: 'sayonaraerezi'
      click_button 'ログイン'
      expect(current_path).to eq user_path(user.id)
      expect(page).to have_content 'ログインしました。'
      expect(page).to have_content 'すだまさき'
    end
    context '記録を新規作成した場合' do
      it '食品一覧画面の一番最初に表示される' do
        FactoryBot.create(:food, user: user)
        FactoryBot.create(:second_food, user: user)
        click_on '記録作成'
        expect(current_path).to eq foods_path
        expect(page).to have_content '食品一覧'
        expect(page).to have_content '卵'
        expect(page).to have_content '納豆'
        food_list = all('.text-center')
        expect(food_list[0]).to have_content "卵"
      end
    end
  end
end