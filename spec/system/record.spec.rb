require 'rails_helper'
describe '食品記録機能', type: :system do
  let!(:user) { FactoryBot.create(:user)}
  let!(:second_user) { FactoryBot.create(:second_user)}
  let!(:food) { FactoryBot.create(:food, user: user)}
  let!(:second_food) { FactoryBot.create(:second_food, user: user)}
  let!(:third_food) { FactoryBot.create(:third_food, user: second_user)}
  let!(:record) { FactoryBot.create(:record, user: user, food: food)}
  let!(:second_record) { FactoryBot.create(:second_record, user: user, food: second_food)}
  let!(:third_record) { FactoryBot.create(:third_record, user: second_user, food: third_food)}
  let!(:fourth_record) { FactoryBot.create(:fourth_record, user: second_user, food: third_food)}
  describe '食品記録管理テスト' do
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
      it '食品一覧画面で日付順に表示される' do
        click_on '記録作成'
        expect(current_path).to eq new_record_path
        expect(page).to have_content '記録作成'
        select "納豆", from: :record_food_id
        fill_in 'record[ate]', with: 1
        fill_in 'record[record_on]', with: "002021-06-09"
        click_on "登録"
        expect(current_path).to eq records_path
        expect(page).to have_content '食品記録完了'
        expect(page).to have_content '卵'
        expect(page).to have_content '納豆'
        expect(page).to have_content '豆腐'
        expect(5).to eq Record.count
        tds = all("td")
        expect(tds[0]).to have_content "納豆"
        table_days = all(".table_date")
        expect(table_days[0]).to have_content "2021-06-09"
        table_user_names = all(".table_user_name")
        expect(table_user_names[0]).to have_content "すだまさき"
      end
    end
  end
end