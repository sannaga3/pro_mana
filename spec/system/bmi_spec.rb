require 'rails_helper'

describe "BMI管理機能", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:bmi) { FactoryBot.build(:bmi, user: user) }
  let!(:second_bmi) { FactoryBot.create(:second_bmi, user: user) }
  describe 'BMI管理機能テスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: 'machigaisagasi@example.com'
      fill_in 'user[password]', with: 'sayonaraerezi'
      click_button 'ログイン'
      expect(current_path).to eq user_path(user.id)
      expect(page).to have_content 'ログインしました。'
      expect(page).to have_content 'すだまさき'
      click_on 'BMI'
      sleep(0.5)
    end
    context 'BMIを新規作成した場合' do
      it '最新の記録がBMI一覧ページの一番上に表示される' do
        expect(current_path).to eq bmis_path
        click_on "BMI作成"
        expect(current_path).to eq new_bmi_path
        fill_in 'bmi[height]', with: 160
        fill_in 'bmi[weight]', with: 57.2
        fill_in 'bmi[record_on]', with: '002021-07-06'
        click_on '登録'
        expect(current_path).to eq bmis_path
        first_record_on = find('#record_on0')
        expect(first_record_on).to have_content '2021-07-06'
        first_status = find('#status0')
        expect(first_status).to have_content 22.3
        first_height = find('#height0')
        expect(first_height).to have_content 160
        first_weight = find('#weight0')
        expect(first_weight).to have_content 57.2
        expect(Bmi.count).to eq 2
      end
    end
    context 'BMIを編集した場合' do
      it '編集内容がBMI一覧に表示される' do
        expect(current_path).to eq bmis_path
        find(:link, "編集").click
        expect(current_path).to eq edit_bmi_path(second_bmi.id)
        fill_in 'bmi[height]', with: 160
        fill_in 'bmi[weight]', with: 56
        fill_in 'bmi[record_on]', with: '002021-07-08'
        click_on '更新'
        expect(current_path).to eq bmis_path
        binding.irb
        first_record_on = find('#record_on0')
        expect(first_record_on).to have_content '2021-07-08'
        first_status = find('#status0')
        expect(first_status).to have_content 21.9
        first_height = find('#height0')
        expect(first_height).to have_content 160
        first_weight = find('#weight0')
        expect(first_weight).to have_content 56
        expect(Bmi.count).to eq 1
      end
    end
    context 'BMIを削除した場合' do
      it 'BMI一覧から該当のインスタンスが削除される' do
        expect(current_path).to eq bmis_path
        find(:link, "削除").click
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq bmis_path
        expect(Bmi.count).to eq 0
      end
    end
  end
end
