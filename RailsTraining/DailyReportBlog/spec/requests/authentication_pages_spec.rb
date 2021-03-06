# -*- coding: utf-8 -*-
require 'rails_helper'
include ApplicationHelper

RSpec.describe "AuthenticationPages", type: :request do

  describe "signin page" do
    before { visit signin_path }

    it "should have valid contents" do
      expect(page).to have_content(I18n.t('sign_in'))
      expect(page).to have_title(I18n.t('sign_in'))
    end

    describe "with invalid information" do
      before { click_button I18n.t('sign_in') }

      it "should have valid contents" do
        expect(page).to have_title(I18n.t('sign_in'))
        expect(page).to have_selector('div.alert.alert-danger', text: 'Invalid')
      end

      context "after visiting another page" do
        before { click_link I18n.t('home') }
        it { expect(page).not_to have_selector('div.alert.alert-danger') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button I18n.t('sign_in')
      end

      it "should have valid contents" do
        expect(page).to have_title(user.name)
        expect(page).to have_link(I18n.t('users'), href: users_path)
        expect(page).to have_link(I18n.t('profile'), href: user_path(user))
        expect(page).to have_link(I18n.t('settings'), href: settings_path)
        expect(page).to have_link(I18n.t('sign_out'), href: signout_path)
        expect(page).not_to have_link(I18n.t('sing_up'), href: signin_path)
      end

      describe "followed by signout" do
        before { click_link I18n.t('sign_out') }
        it { expect(page).to have_link(I18n.t('sign_in')) }
      end
    end
  end

  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do
        context "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { expect(page).to have_title(I18n.t('sign_in')) }
        end

        context "submitting to the update action" do
          # PATCHリクエストを 直接/users/1に発行
          # このリクエストはUsersコントローラのupdateアクションにルーティングされる
          # (ブラウザはupdateアクションを直接表示することができないため)
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        context "visiting ther user index" do
          before { visit users_path }
          it { expect(page).to have_title(I18n.t('sign_in')) }
        end

        describe "in the Microposts controller" do
          context "submitting to the create action" do
            before { post blogs_path }
            specify { expect(response).to redirect_to(signin_path) }
          end

          context "submitting to the destroy action" do
            before { delete blog_path(FactoryGirl.create(:blog)) }
            specify { expect(response).to redirect_to(signin_path) }
          end
        end
      end

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button I18n.t('sign_in')
        end

        describe "after signing in" do
          it "should render the desired protected page" do
            expect(page).to have_content(I18n.t('settings'))
          end
        end
      end

      describe "as non-admin user" do
        let(:user) { FactoryGirl.create(:user) }
        let(:non_admin) { FactoryGirl.create(:user) }

        before { sign_in non_admin, no_capybara: true }

        context "submitting a DELETE request to the Users#destroy action" do
          before { delete user_path(user) }
          specify { expect(response).to redirect_to(root_path) }
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title(I18n.t('edit_user'))) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end
  end
end
