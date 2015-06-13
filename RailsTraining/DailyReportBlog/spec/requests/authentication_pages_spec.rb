# -*- coding: utf-8 -*-
require 'rails_helper'

RSpec.describe "AuthenticationPages", type: :request do

  describe "signin page" do
    before { visit signin_path }

    it "should have valid contents" do
      expect(page).to have_content('Sign in')
      expect(page).to have_title('Sign in')
    end

    describe "with invalid information" do
      before { click_button "Sign in" }

      it "should have valid contents" do
        expect(page).to have_title('Sign in')
        expect(page).to have_selector('div.alert.alert-danger', text: 'Invalid')
      end

      context "after visiting another page" do
        before { click_link "Home" }
        it { expect(page).not_to have_selector('div.alert.alert-danger') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it "should have valid contents" do
        expect(page).to have_title(user.name)
        expect(page).to have_link('Profile', href: user_path(user))
        expect(page).to have_link('Settings', href: edit_user_path(user))
        expect(page).to have_link('Sign out', href: signout_path)
        expect(page).not_to have_link('Sign in', href: signin_path)
      end

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { expect(page).to have_link('Sign in') }
      end
    end
  end
end
