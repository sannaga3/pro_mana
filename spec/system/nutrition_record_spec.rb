require 'rails_helper'
describe '食品記録機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:second_user) { FactoryBot.create(:second_user) }
  let!(:food) { FactoryBot.create(:food, user: user) }
  let!(:second_food) { FactoryBot.create(:second_food, user: user) }
  let!(:third_food) { FactoryBot.create(:third_food, user: second_user) }
  let!(:fourth_food) { FactoryBot.create(:fourth_food, user: user) }
  let!(:record) { FactoryBot.create(:record, user: user) }
  let!(:second_record) { FactoryBot.create(:second_record, user: user) }
  let!(:third_record) { FactoryBot.create(:third_record, user: second_user) }
  let!(:fourth_record) { FactoryBot.create(:fourth_record, user: second_user) }
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
        expect(current_path).to eq new_nutrition_record_path
        expect(page).to have_content '記録作成'
        expect(4).to eq NutritionRecord.count
        select '納豆', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        fill_in 'nutrition_record[nutrition_record_lines_attributes][0][ate]', with: 1
        fill_in 'nutrition_record[start_time]', with: '002021-06-09'
        click_on '登録'
        expect(current_path).to eq nutrition_record_path(NutritionRecord.last.id)
        expect(page).to have_content '記録作成完了'
        expect(page).to have_content '納豆'
        expect(page).to have_content 1
        expect(page).to have_content '2021-06-09'
        expect(NutritionRecord.count).to eq 5
      end
    end
    context '毎日の記録ページのリンクをクリックした場合' do
      it '自分の記録のみ取得できる' do
        click_on '毎日の記録'
        expect(current_path).to eq my_daily_nutrition_records_path
        expect(page).to have_content '毎日の記録'
        expect(NutritionRecord.where(user_id: user.id).count).to eq 2
        execute_script('window.scrollBy(0,10000)')
        first_food_name = find('#food_name0')
        expect(first_food_name).to have_content '卵'
        second_food_name = find('#food_name1')
        expect(second_food_name).to have_content '鳥もも肉'
        third_food_name = find('#food_name2')
        expect(third_food_name).to have_content '納豆'
        table_days = all('.table_date')
        expect(table_days[0]).to have_content '2021-06-06'
        total_proteins = all('.total_protein')
        expect(total_proteins[0]).to have_content 'タンパク質量合計 20 g'
        expect(total_proteins[1]).to have_content 'タンパク質量合計 4 g'
      end
    end
    context '毎日の記録ページから詳細ボタンをクリックした場合' do
      it '詳細ページが表示される' do
        click_on '毎日の記録'
        expect(current_path).to eq my_daily_nutrition_records_path
        expect(page).to have_content '毎日の記録'
        expect(2).to eq NutritionRecord.where(user_id: user.id).count
        first_food_name = find('#food_name0')
        expect(first_food_name).to have_content '卵'
        find('#show_button0').click
        expect(current_path).to eq nutrition_record_path(second_record.id)
        expect(page).to have_content '記録詳細'
        expect(page).to have_content '卵'
        expect(page).to have_content 4
        expect(page).to have_content 2
        expect(page).to have_content '個'
        expect(page).to have_content '2021-06-06'
      end
    end
    context '編集ページの内容を更新した場合' do
      it '更新内容が詳細ページに反映される' do
        click_on '毎日の記録'
        expect(current_path).to eq my_daily_nutrition_records_path
        expect(page).to have_content '毎日の記録'
        expect(2).to eq NutritionRecord.where(user_id: user.id).count
        first_food_name = find('#food_name0')
        expect(first_food_name).to have_content '卵'
        find('#edit_button0').click
        expect(current_path).to eq edit_nutrition_record_path(second_record.id)
        expect(page).to have_content '記録編集'
        expect(page).to have_content '卵'
        expect(page).to have_content 4
        fill_in 'nutrition_record[start_time]',	with: '002021-06-06'
        select '納豆', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        fill_in "nutrition_record[nutrition_record_lines_attributes][0][ate]",	with: 3
        click_on "更新"
        expect(page).to have_content '記録詳細'
        expect(page).to have_content '納豆'
        expect(page).to have_content 4
        expect(page).to have_content 3
        expect(page).to have_content 'パック'
        expect(page).to have_content '2021-06-06'
      end
    end
    context 'みんなの記録ページへ遷移した場合' do
      it '記録全てが日付の降順かつユーザー毎に表示される' do
        click_on 'みんなの記録'
        expect(current_path).to eq nutrition_records_path
        expect(page).to have_content 'みんなの記録'
        first_food_name = find('#food_name0')
        expect(first_food_name).to have_content '豆腐'
        second_food_name = find('#food_name1')
        expect(second_food_name).to have_content '卵'
        third_food_name = find('#food_name2')
        expect(third_food_name).to have_content '鳥もも肉'
        fourth_food_name = find('#food_name3')
        expect(fourth_food_name).to have_content '納豆'
        fifth_food_name = find('#food_name4')
        expect(fifth_food_name).to have_content '豆腐'
        expect(4).to eq NutritionRecord.count
        table_days = all('.table_date')
        expect(table_days[0]).to have_content '2021-06-07'
        expect(table_days[1]).to have_content '2021-06-06'
        expect(table_days[2]).to have_content '2021-06-05'
        expect(table_days[3]).to have_content '2021-06-05'
        table_user_names = all('.table_user_name')
        expect(table_user_names[0]).to have_content 'garnetcrow'
        expect(table_user_names[1]).to have_content 'すだまさき'
        expect(table_user_names[2]).to have_content 'すだまさき'
        expect(table_user_names[3]).to have_content 'garnetcrow'
      end
    end
    context '毎日の記録ページから削除ボタンをクリックした場合' do
      it '対象の記録が削除される' do
        click_on '毎日の記録'
        expect(current_path).to eq my_daily_nutrition_records_path
        expect(page).to have_content '毎日の記録'
        expect(2).to eq NutritionRecord.where(user_id: user.id).count
        first_food_name = find('#food_name0')
        expect(first_food_name).to have_content '卵'
        second_food_name = find('#food_name1')
        expect(second_food_name).to have_content '鳥もも肉'
        third_food_name = find('#food_name2')
        expect(third_food_name).to have_content '納豆'
        find('#delete_button0').click
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq my_daily_nutrition_records_path
        expect(1).to eq NutritionRecord.where(user_id: user.id).count
        expect(page).to have_content '毎日の記録'
        first_food_name = find('#food_name0')
        expect(first_food_name).to have_content '納豆'
        table_dates = all('.table_date')
        expect(table_dates[0]).to have_content '2021-06-05'
      end
    end
    context '食品検索で食品名にて検索した場合' do
      it '記録詳細ページであいまい検索かつ自身の食品のみが食品選択欄で選択できる' do
        click_on '記録作成'
        expect(current_path).to eq new_nutrition_record_path
        expect(page).to have_content '記録作成'
        expect(page).to have_content '食品検索'
        options = all('option')
        expect(options.count).to eq 4
        select '納豆', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        select '鳥もも肉', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        select '卵', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        select '選択して下さい', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        fill_in 'q[name_cont]', with: '納'
        click_on '検索'
        expect(current_path).to eq new_nutrition_record_path
        options = all('option')
        expect(options.count).to eq 2
        select '納豆', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        select '選択して下さい', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
      end
    end
    context '食品検索でタンパク質含有量の値で検索した場合' do
      it '記録詳細ページで検索した値と同じタンパク質量の食品かつ自身の食品のみが食品選択欄で選択できる' do
        click_on '記録作成'
        expect(current_path).to eq new_nutrition_record_path
        expect(page).to have_content '記録作成'
        expect(page).to have_content '食品検索'
        options = all('option')
        expect(options.count).to eq 4
        select '納豆', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        select '鳥もも肉', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        select '卵', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        select '選択して下さい', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        fill_in 'q[protein_eq]', with: 12
        click_on '検索'
        expect(current_path).to eq new_nutrition_record_path
        options = all('option')
        expect(options.count).to eq 2
        select '鳥もも肉', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        select '選択して下さい', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
      end
    end

    context '食品検索でタンパク質含有量の値以上で検索した場合' do
      it '記録詳細ページで検索した値以上のタンパク質量の食品かつ自身の食品のみが食品選択欄で選択できる' do
        click_on '記録作成'
        expect(current_path).to eq new_nutrition_record_path
        expect(page).to have_content '記録作成'
        expect(page).to have_content '食品検索'
        options = all('option')
        expect(options.count).to eq 4
        select '納豆', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        select '鳥もも肉', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        select '卵', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        select '選択して下さい', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        fill_in 'q[protein_gteq]', with: 6
        click_on '検索'
        expect(current_path).to eq new_nutrition_record_path
        options = all('option')
        expect(options.count).to eq 2
        select '鳥もも肉', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        select '選択して下さい', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
      end
    end
    context '食品検索でタンパク質含有量の値以下で検索した場合' do
      it '記録詳細ページで検索した値以下のタンパク質量の食品かつ自身の食品のみが食品選択欄で選択できる' do
        click_on '記録作成'
        expect(current_path).to eq new_nutrition_record_path
        expect(page).to have_content '記録作成'
        expect(page).to have_content '食品検索'
        options = all('option')
        expect(options.count).to eq 4
        select '納豆', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        select '卵', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        select '鳥もも肉', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        select '選択して下さい', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        fill_in 'q[protein_lteq]', with: 4
        click_on '検索'
        expect(current_path).to eq new_nutrition_record_path
        options = all('option')
        expect(options.count).to eq 3
        select '納豆', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        select '卵', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
        select '選択して下さい', from: :nutrition_record_nutrition_record_lines_attributes_0_food_id
      end
    end
  end
end
