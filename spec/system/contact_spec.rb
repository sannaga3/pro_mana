require 'rails_helper'

describe 'お問合せ管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let(:contact) { FactoryBot.build(:contact, user: user) }
  let!(:second_contact) { FactoryBot.create(:second_contact, user: user) }
  describe 'お問合せ管理機能テスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: 'machigaisagasi@example.com'
      fill_in 'user[password]', with: 'sayonaraerezi'
      click_button 'ログイン'
      expect(current_path).to eq user_path(user.id)
      expect(page).to have_content 'ログインしました。'
      expect(page).to have_content 'すだまさき'
      click_on 'お問合せ'
    end
    context 'お問合せを新規作成した場合' do
      it 'お問合せ一覧ページの一番最初に表示される' do
        expect(current_path).to eq contacts_path
        expect(Contact.count).to eq 1
        click_on '新規お問合せ'
        expect(current_path).to eq new_contact_path
        fill_in 'contact[title]', with: 'ジャングルはいつもハレのちグゥ'
        fill_in 'contact[content]', with: 'ハレグゥ'
        click_on '登録'
        sleep(0.5)
        expect(current_path).to eq contacts_path
        first_user = find('#user0')
        expect(first_user).to have_content 'すだまさき'
        first_title = find('#title0')
        expect(first_title).to have_content 'ジャングルはいつもハレのちグゥ'
        expect(Contact.count).to eq 2
      end
    end
    context '食品を編集した場合' do
      it '編集内容が詳細ページで確認できる' do
        expect(current_path).to eq contacts_path
        expect(Contact.count).to eq 1
        find(:link, '詳細').click
        find(:link, '編集').click
        expect(current_path).to eq edit_contact_path(second_contact.id)
        fill_in 'contact[title]', with: 'ジャングルはいつもハレのちグゥ'
        fill_in 'contact[content]', with: 'ハレグゥ'
        click_on '更新'
        sleep(0.5)
        expect(current_path).to eq contacts_path
        first_user = find('#user0')
        expect(first_user).to have_content 'すだまさき'
        first_title = find('#title0')
        expect(first_title).to have_content 'ジャングルはいつもハレのちグゥ'
        find(:link, '詳細').click
        expect(current_path).to eq contact_path(second_contact.id)
        expect(page).to have_content 'すだまさき'
        expect(page).to have_content 'ジャングルはいつもハレのちグゥ'
        expect(Contact.count).to eq 1
      end
    end
    context 'お問合せを削除した場合' do
      it '該当のお問合せが削除される' do
        expect(current_path).to eq contacts_path
        expect(Contact.count).to eq 1
        find(:link, '削除').click
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq contacts_path
        expect(Contact.count).to eq 0
      end
    end
  end
end
