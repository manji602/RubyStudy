# -*- coding: utf-8 -*-

# Capybaraを使用していないとフォームへの自動入力が動作しない。
# このような場合に備えて、ユーザーからno_capyabara: trueオプションを渡せるようにし、デフォルトのサインインメソッドを上書きしてcookiesを直接操作できるようにする。
# これは、HTTPリクエスト (get、post、patch、delete) を直接使用する場合には必要。
def sign_in(user, options={})
  if options[:no_capybara]
    # Capybaraを使用していない場合にもサインインする。
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button I18n.t('sign_in')
  end
end
