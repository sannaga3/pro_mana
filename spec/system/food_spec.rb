require 'rails_helper'
describe '食品機能', type: :system do
  describe '食品管理機能テスト' do
    let!(:user) { FactoryBot.create(:user) }
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
    context '食品を新規作成した場合' do
      it '食品一覧画面の一番最初に表示される' do
        fill_in 'food[name]', with: '鳥もも肉'
        fill_in 'food[protein]', with: 12
        fill_in 'food[quantity]', with: 50
        fill_in 'food[unit]', with: 'g'
        click_on '登録'
        sleep(0.5)
        expect(current_path).to eq foods_path
        expect(page).to have_content '食品登録完了'
        expect(page).to have_content '食品一覧'
        expect(page).to have_content '鳥もも肉'
        expect(Food.count).to eq 1
      end
    end
    context '食品を編集した場合' do
      it '食品一覧画面の一番最初に表示される' do
        FactoryBot.create(:food, user: user)
        FactoryBot.create(:second_food, user: user)
        click_on '食品一覧'
        expect(current_path).to eq foods_path
        expect(page).to have_content '食品一覧'
        expect(page).to have_content '卵'
        expect(page).to have_content '納豆'
        food_list = all('.text-center')
        expect(food_list[0]).to have_content '卵'
      end
    end
    context '食品を削除した場合' do
      it '食品一覧から削除した食品が削除されている' do
        FactoryBot.create(:food, user: user)
        second_food = FactoryBot.create(:second_food, user: user)
        click_on '食品一覧'
        expect(current_path).to eq foods_path
        expect(page).to have_content '食品一覧'
        expect(page).to have_content '卵'
        expect(page).to have_content '納豆'
        find('#delete_button0').click
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq foods_path
        expect(page).not_to have_content '卵'
        expect(1).to eq Food.count
      end
    end
    context 'みんなの食品ページから自分の食品に登録するボタンを押した時' do
      it '他のユーザーの食品を自分の食品として登録できる' do
        food = FactoryBot.create(:food, user: user)
        third_user = FactoryBot.create(:third_user)
        third_food = FactoryBot.create(:third_food, user: third_user)
        record = FactoryBot.create(:record, user: user)
        third_record = FactoryBot.create(:third_record, user: third_user)
        click_on 'みんなの記録'
        expect(current_path).to eq nutrition_records_path
        expect(page).to have_content 'みんなの記録'
        expect(page).to have_content '納豆'
        expect(page).to have_content '豆腐'
        expect(Food.count).to eq 2
        find('#my_food_button0').click
        expect(current_path).to eq foods_path
        first_food = find('#food_name0')
        expect(first_food).to have_content '豆腐'
        expect(page).to have_content '納豆'
        expect(Food.count).to eq 3
      end
    end
  end
end
