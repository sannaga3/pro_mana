require 'rails_helper'

describe "お問合せ管理機能", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:third_user) { FactoryBot.create(:third_user) }
  let!(:contact) { FactoryBot.create(:contact, user: user) }
  let!(:second_contact) { FactoryBot.create(:second_contact, user: third_user) }
  describe '返信管理機能テスト' do
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
    context '一般ユーザーのお問合せに管理者ユーザーが返信を作成した場合' do
      it '返信内容がお問合せ詳細ページに反映される' do
        first(:link, "詳細").click
        expect(current_path).to eq contact_path(second_contact.id)
        expect(Reply.count).to eq 0
        click_on "返信作成"
        expect(current_path).to eq new_reply_path
        fill_in 'reply[comment]', with: 'チョヒャド！！チョヒャド！！チョヒャド！！チョヒャド！！チョヒャド！！チョヒャド！！チョヒャド！！'
        click_on '登録'
        sleep(0.5)
        expect(current_path).to eq contact_path(second_contact.id)
        first_replier = find('#replier0')
        expect(first_replier).to have_content 'すだまさき'
        first_comment = find('#comment0')
        expect(first_comment).to have_content 'チョヒャド！！チョヒャド！！チョヒャド！！チョヒャド！！チョヒャド！！チョヒャド！！チョヒャド！！'
        expect(Reply.count).to eq 1
      end
    end
    context '管理者ユーザーの返信に対して一般ユーザーが返信を返した場合' do
      it '返信内容がお問合せ詳細ページに2番目の返信として反映される' do
        FactoryBot.create(:reply, contact: second_contact, user_id: user.id)
        click_on "ログアウト"
        visit new_user_session_path
        fill_in 'user[email]', with: 'arigatou@example.com'
        fill_in 'user[password]', with: 'himitsu'
        click_button 'ログイン'
        click_on 'お問合せ'
        first(:link, "詳細").click
        expect(current_path).to eq contact_path(second_contact.id)
        expect(Reply.count).to eq 1
        click_on '返信作成'
        expect(current_path).to eq new_reply_path
        fill_in 'reply[comment]', with: 'ちょっと寒くなった気がする'
        click_on '登録'
        sleep(0.5)
        expect(current_path).to eq contact_path(second_contact.id)
        first_replier = find('#replier0')
        expect(first_replier).to have_content 'すだまさき'
        first_comment = find('#comment0')
        expect(first_comment).to have_content 'ヨシピコーーー！'
        second_replier = find('#replier1')
        expect(second_replier).to have_content 'SUPER BEAVER'
        second_comment = find('#comment1')
        expect(second_comment).to have_content 'ちょっと寒くなった気がする'
        expect(Reply.count).to eq 2
      end
    end
    context '自分の返信内容を編集した場合' do
      it '編集内容がお問合せ詳細ページに反映される' do
        FactoryBot.create(:reply, contact: second_contact, user_id: user.id)
        first(:link, "詳細").click
        expect(current_path).to eq contact_path(second_contact.id)
        expect(Reply.count).to eq 1
        find("#edit_button0").click
        expect(page).to have_content "返信編集"
        fill_in 'reply[comment]', with: '仏だけにほっとけよー'
        click_on '更新'
        sleep(0.5)
        expect(current_path).to eq contact_path(second_contact.id)
        first_replier = find('#replier0')
        expect(first_replier).to have_content 'すだまさき'
        first_comment = find('#comment0')
        expect(first_comment).to have_content '仏だけにほっとけよー'
        expect(Reply.count).to eq 1
      end
    end
    context '自分の返信内容を削除した場合' do
      it 'お問合せ詳細ページから該当の返信が削除される' do
        FactoryBot.create(:reply, contact: second_contact, user_id: user.id)
        first(:link, "詳細").click
        expect(current_path).to eq contact_path(second_contact.id)
        expect(Reply.count).to eq 1
        find("#destroy_button0").click
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq contact_path(second_contact.id)
        expect(Reply.count).to eq 0
      end
    end
  end
end
