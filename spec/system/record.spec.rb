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
      it '記録詳細ページで登録内容を確認できる' do
        click_on '記録作成'
        expect(current_path).to eq new_record_path
        expect(page).to have_content '記録作成'
        expect(4).to eq Record.count
        select "納豆", from: :record_food_id
        fill_in 'record[ate]', with: 1
        fill_in 'record[record_on]', with: "002021-06-09"
        click_on "登録"
        expect(current_path).to eq record_path(Record.last.id)
        expect(page).to have_content '記録作成完了'
        expect(page).to have_content '納豆'
        expect(page).to have_content  1
        expect(page).to have_content "2021-06-09"
        expect(5).to eq Record.count
      end
    end
    context '毎日の記録ページのリンクをクリックした場合' do
      it '自分の記録のみ取得できる' do
        click_on '毎日の記録'
        expect(current_path).to eq my_daily_records_path
        expect(page).to have_content '毎日の記録'
        expect(2).to eq Record.where(user_id: user.id).count
        tds = all("td")
        expect(tds[0]).to have_content "卵"
        expect(page).to have_content "納豆"
        table_days = all(".table_date")
        expect(table_days[0]).to have_content "2021-06-06"
        total_proteins = all(".total_protein")
        expect(total_proteins[0]).to have_content "タンパク質摂取量合計 4 g"
        expect(total_proteins[1]).to have_content "タンパク質摂取量合計 4 g"
      end
    end
    context '毎日の記録ページから詳細ボタンをクリックした場合' do
      it '詳細ページが表示される' do
        click_on '毎日の記録'
        expect(current_path).to eq my_daily_records_path
        expect(page).to have_content '毎日の記録'
        expect(2).to eq Record.where(user_id: user.id).count
        tds = all("td")
        expect(tds[0]).to have_content "卵"
        find('#show_button0').click
        expect(current_path).to eq record_path(second_record.id)
        expect(page).to have_content "記録詳細"
        expect(page).to have_content "卵"
        expect(page).to have_content 4
        expect(page).to have_content 1
        expect(page).to have_content "個"
        expect(page).to have_content "2021-06-06"
      end
      context '編集ページの内容を更新した場合' do
        it '更新内容が詳細ページに反映される' do
          click_on '毎日の記録'
          expect(current_path).to eq my_daily_records_path
          expect(page).to have_content '毎日の記録'
          expect(2).to eq Record.where(user_id: user.id).count
          tds = all("td")
          expect(tds[0]).to have_content "卵"
          find('#edit_button0').click
          expect(current_path).to eq edit_record_path(second_record.id)
          expect(page).to have_content "記録編集"
          expect(page).to have_content "卵"
          expect(page).to have_content 4
          expect(page).to have_content 1
          expect(page).to have_content "個"
        end
      end
      context 'みんなの記録ページへ遷移した場合' do
        it '記録全てが日付の降順かつユーザー毎に表示される' do
          click_on 'みんなの記録'
          expect(current_path).to eq records_path
          expect(page).to have_content 'みんなの記録'
          tds = all("td")
          expect(tds[0]).to have_content "豆腐"
          expect(tds[6]).to have_content "卵"
          expect(tds[12]).to have_content "納豆"
          expect(tds[18]).to have_content "豆腐"
          expect(4).to eq Record.count
          table_days = all(".table_date")
          expect(table_days[0]).to have_content "2021-06-07"
          expect(table_days[1]).to have_content "2021-06-06"
          expect(table_days[2]).to have_content "2021-06-05"
          expect(table_days[3]).to have_content "2021-06-05"
          table_user_names = all(".table_user_name")
          expect(table_user_names[0]).to have_content "garnetcrow"
          expect(table_user_names[1]).to have_content "すだまさき"
          expect(table_user_names[2]).to have_content "すだまさき"
          expect(table_user_names[3]).to have_content "garnetcrow"
        end
      end
      context '毎日の記録ページから削除ボタンをクリックした場合' do
        it '対象の記録が削除される' do
          click_on '毎日の記録'
          expect(current_path).to eq my_daily_records_path
          expect(page).to have_content '毎日の記録'
          expect(2).to eq Record.where(user_id: user.id).count
          tds = all("td")
          expect(tds[0]).to have_content "卵"
          expect(tds[8]).to have_content "納豆"
          find('#delete_button0').click
          page.driver.browser.switch_to.alert.accept
          expect(current_path).to eq my_daily_records_path
          expect(1).to eq Record.where(user_id: user.id).count
          expect(page).to have_content "毎日の記録"
          tds = all("td")
          expect(tds[0]).to have_content "納豆"
          table_dates = all(".table_date")
          expect(table_dates[0]).to have_content "2021-06-05"
        end
      end
      context '食品検索で食品名にて検索した場合' do
        it '記録詳細ページであいまい検索かつ自身の食品のみが食品選択欄で選択できる' do
          click_on '記録作成'
          expect(current_path).to eq new_record_path
          expect(page).to have_content '記録作成'
          expect(page).to have_content '食品検索'
          options = all('option')
          select "納豆", from: :record_food_id
          select "卵", from: :record_food_id
          expect(options.count).to eq 2
          fill_in 'q[name_cont]', with: '納'
          click_on "検索"
          expect(current_path).to eq new_record_path
          options = all('option')
          select "納豆", from: :record_food_id
          expect(options.count).to eq 1
        end
      end
    end
  end
end