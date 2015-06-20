require 'rails_helper'

RSpec.describe "UserPages", type: :request do
  subject{ page }

  describe "create account" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it "should display user page" do
      expect(page).to have_content(user.name)
      expect(page).to have_title("DailyReportBlog | #{user.name}")
    end
  end

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title("DailyReportBlog | #{I18n.t('users')}") }
    it { should have_content(I18n.t('users')) }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do
      it { expect(page).not_to have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { expect(page).to have_link(I18n.t('delete'), href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link(I18n.t('delete'), match: :first) }.to change(User, :count).by(-1)
        end
        it { expect(page).not_to have_link(I18n.t('delete'), href: user_path(admin)) }
      end
    end
  end


  describe "signup page" do
    before { visit signup_path }

    it "should display sign up page" do
      expect(page).to have_content(I18n.t('sign_up'))
      expect(page).to have_title("DailyReportBlog | #{I18n.t('sign_up')}")
    end
  end

  describe "signup" do
    before { visit signup_path }
    let(:submit) { I18n.t('sign_up_now') }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in I18n.t('confirm_password'), with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      context "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it "should be logined status" do
          expect(page).to have_link(I18n.t('sign_out'))
          expect(page).to have_title(user.name)
          expect(page).to have_selector('div.alert.alert-success', text: 'Welcome')
        end
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    it "should be valid contents" do
      expect(page).to have_content(I18n.t('edit_account'))
      expect(page).to have_title("DailyReportBlog | #{I18n.t('edit_account')}")
      expect(page).to have_link(I18n.t('edit_gravatar'), href: 'http://gravatar.com/emails')
    end

    context "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in I18n.t('confirm_password'), with: user.password
        click_button I18n.t('save_changes')
      end

      it "should be valid success response" do
        expect(page).to have_title(new_name)
        expect(page).to have_selector('div.alert.alert-success')
        expect(user.reload.name).to eq new_name
        expect(user.reload.email).to eq new_email
      end
    end

    context "with invalid information" do
      before { click_button I18n.t('save_changes') }

      it "should be valid error response" do
        expect(page).to have_content('error')
      end
    end
  end
end
