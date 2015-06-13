require 'rails_helper'

RSpec.describe "UserPages", type: :request do
  describe "User pages" do

    subject{ page }

    describe "create account" do
      let(:user) { FactoryGirl.create(:user) }
      before { visit user_path(user) }

      it "should display user page" do
        expect(page).to have_content(user.name)
        expect(page).to have_title("DailyReportBlog | #{user.name}")
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
  end
end
