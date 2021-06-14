require 'rails_helper'
describe '食品機能', type: :system do
  describe '食品新規登録テスト' do
    let(:food) { FactoryBot.create(:food)}
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: 'machigaisagasi@example.com'
      fill_in 'user[password]', with: 'sayonaraerezi'
      click_button 'ログイン'
      expect(current_path).to eq user_path(user.id)
      expect(page).to have_content 'ログインしました。'
      expect(page).to have_content 'すだまさき'
      click_on '食品登録'
    end
    context 'プロフィール画像以外の項目を入力した場合' do
      it '自身のプロフィールを更新できる(プロフィール画像以外)' do
        fill_in 'food[name]', with: '鳥もも肉'
        fill_in 'food[protein]', with: '12'
        fill_in 'food[quantity]', with: '50'
        fill_in 'food[unit]', with: 'g'
        click_on '登録'
        expect(current_path).to eq foods_path
        expect(page).to have_content '食品登録完了'
        expect(page).to have_content '食品一覧'
        expect(page).to have_content ''
      end
    end
  end
end