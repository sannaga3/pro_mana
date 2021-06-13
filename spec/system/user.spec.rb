require 'rails_helper'
describe 'ユーザー機能', type: :system do
  describe 'ユーザーの新規登録テスト' do
    before do
      visit new_user_registration_path
    end
    context '名前、メールアドレス、パスワードが正しい場合,' do
      it '新規登録ができる' do
        fill_in 'user[name]', with: 'すだまさき'
        fill_in 'user[email]', with: 'machigaisagasi@example.com'
        fill_in 'user[password]', with: 'sayonaraerezi'
        fill_in 'user[password_confirmation]', with: 'sayonaraerezi'
        click_button 'アカウント登録'
        expect(page).to have_content 'アカウント登録が完了しました。'
        expect(page).to have_content 'すだまさき'
        expect(User.count).to eq(1)
      end
    end
    context '名前が未記入の場合' do
      it 'バリデーションエラーになる' do
        fill_in 'user[name]', with: ''
        fill_in 'user[email]', with: 'machigaisagasi@example.com'
        fill_in 'user[password]', with: 'sayonaraerezi'
        fill_in 'user[password_confirmation]', with: 'sayonaraerezi'
        click_button 'アカウント登録'
        expect(page).to have_content 'アカウント登録'
        expect(page).to have_content 'ユーザー名を入力してください'
        expect(page).to have_content 'ユーザー名は1文字以上で入力してください'
      end
    end
    context '名前が51文字以上の場合' do
      it 'バリデーションエラーになる' do
        fill_in 'user[name]', with: "すだまさき"*11
        fill_in 'user[email]', with: 'machigaisagasi@example.com'
        fill_in 'user[password]', with: 'sayonaraerezi'
        fill_in 'user[password_confirmation]', with: 'sayonaraerezi'
        click_button 'アカウント登録'
        expect(page).to have_content 'ユーザー名は50文字以内で入力してください'
      end
    end
    context 'メールアドレスが未入力の場合' do
      it 'バリデーションエラーになる' do
        fill_in 'user[name]', with: "すだまさき"
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: 'sayonaraerezi'
        fill_in 'user[password_confirmation]', with: 'sayonaraerezi'
        click_button 'アカウント登録'
        expect(page).to have_content 'メールアドレスを入力してください'
        expect(page).to have_content 'メールアドレスは1文字以上で入力してください'
      end
    end
    context 'メールアドレスが51文字以上の場合' do
      it 'バリデーションエラーになる' do
        fill_in 'user[name]', with: "すだまさき"
        fill_in 'user[email]', with: 'machigaisagasi'*3 + '@example.com'
        fill_in 'user[password]', with: 'sayonaraerezi'
        fill_in 'user[password_confirmation]', with: 'sayonaraerezi'
        click_button 'アカウント登録'
        expect(page).to have_content '50文字以内で入力してください'
      end
    end
    context 'パスワードが未記入の場合' do
      it 'バリデーションエラーになる' do
        fill_in 'user[name]', with: "すだまさき"
        fill_in 'user[email]', with: 'machigaisagasi@example.com'
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button 'アカウント登録'
        expect(page).to have_content 'パスワードを入力してください'
      end
    end
    context 'パスワードが51文字以上の場合' do
      it 'バリデーションエラーになる' do
        fill_in 'user[name]', with: "すだまさき"
        fill_in 'user[email]', with: 'machigaisagasi@example.com'
        fill_in 'user[password]', with: 'sayonaraerezi'*4
        fill_in 'user[password_confirmation]', with: 'sayonaraerezi'*4
        click_button 'アカウント登録'
        expect(page).to have_content 'パスワードは50文字以内で入力してください'
      end
    end
    context 'パスワードが一致しない場合' do
      it 'バリデーションエラーになる' do
        fill_in 'user[name]', with: "すだまさき"
        fill_in 'user[email]', with: 'machigaisagasi@example.com'
        fill_in 'user[password]', with: 'sayonaraerezi'
        fill_in 'user[password_confirmation]', with: 'sayonarae'
        click_button 'アカウント登録'
        expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
      end
    end
  end
  describe 'ユーザーのログインテスト' do
    let!(:user) { FactoryBot.create(:user)}
    before do
      visit new_user_session_path
    end
    context 'メールアドレス、パスワードが正しい場合,' do
      it 'ログインしてプロフィールページへ飛ぶ' do
        fill_in 'user[email]', with: 'machigaisagasi@example.com'
        fill_in 'user[password]', with: 'sayonaraerezi'
        click_button 'ログイン'
        expect(current_path).to eq user_path(user.id)
        expect(page).to have_content 'ログインしました。'
        expect(page).to have_content 'すだまさき'
      end
    end
    context 'メールアドレスが未記入の場合,' do
      it 'ログインできずに「メールアドレスまたはパスワードが違います。」と表示される' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: 'sayonaraerezi'
        click_button 'ログイン'
        expect(page).to have_content 'ログイン'
        expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
      end
    end
    context 'パスワードが未記入の場合,' do
      it 'ログインできずに「メールアドレスまたはパスワードが違います。」と表示される' do
        fill_in 'user[email]', with: 'machigaisagasi@example.com'
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
        expect(page).to have_content 'ログイン'
        expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
      end
    end
    context 'ユーザーがログインしている場合,' do
      it 'ログアウトできること' do
        fill_in 'user[email]', with: 'machigaisagasi@example.com'
        fill_in 'user[password]', with: 'sayonaraerezi'
        click_button 'ログイン'
        expect(current_path).to eq user_path(user.id)
        expect(page).to have_content 'ログインしました。'
        expect(page).to have_content 'すだまさき'
        click_on 'ログアウト'
        expect(current_path).to eq '/'
        expect(page).to have_content 'ログアウトしました。'
        expect(page).to have_content 'ログイン'
      end
    end
  end
end