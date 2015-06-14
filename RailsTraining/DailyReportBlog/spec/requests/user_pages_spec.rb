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
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    it "should list each user" do
      User.all.each do |user|
        expect(page).to have_selector('li', text: user.name)
      end
    end
  end


  describe "signup page" do
    before { visit signup_path }

    it "should display sign up page" do
      expect(page).to have_content('Sign up')
      expect(page).to have_title('DailyReportBlog | Sign up')
    end
  end

  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      context "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it "should be logined status" do
          expect(page).to have_link('Sign out')
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
      expect(page).to have_content("Update your profile")
      expect(page).to have_title("Edit user")
      expect(page).to have_link('change', href: 'http://gravatar.com/emails')
    end

    context "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it "should be valid success response" do
        expect(page).to have_title(new_name)
        expect(page).to have_selector('div.alert.alert-success')
        expect(user.reload.name).to eq new_name
        expect(user.reload.email).to eq new_email
      end
    end

    context "with invalid information" do
      before { click_button "Save changes" }

      it "should be valid error response" do
        expect(page).to have_content('error')
      end
    end
  end
end
