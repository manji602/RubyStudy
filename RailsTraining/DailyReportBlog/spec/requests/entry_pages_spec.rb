require 'rails_helper'

RSpec.describe "EntryPages", type: :request do
  let(:user) { FactoryGirl.create(:user, id: 1) }
  let(:another_user) { FactoryGirl.create(:user, id: 2) }

  before(:each) do
    sign_in user
    user.blog = Blog.create(title: "sample blog", description: "sample description", user_id: user.id);
  end

  describe "create action" do
    before { visit new_entry_path }

    context "should display form" do
      it { expect(page).to have_content('Title') }
      it { expect(page).to have_content('Body') }
    end

    describe "with invalid information" do
      context "form input is empty" do
        before { click_button I18n.t('submit') }
        it { expect(page).to have_content('error') }
      end

      context "manually changed user_id" do
        before do
          find(:xpath, "//input[@name='entry[user_id]']").set another_user.id
          click_button I18n.t('submit')
        end

        it { expect(page).to have_selector('div.alert.alert-warning') }
        it { expect(current_path).to eq(home_path) }
      end
    end

    describe "with valid information" do
      let(:entry_title) { "sample entry" }
      let(:entry_body) { "sample body" }

      before do
        fill_in 'Title', with: entry_title
        fill_in 'Body', with: entry_body
      end

      context "should create entry" do
        it { expect { click_button I18n.t('submit') }.to change(Entry, :count).by(1) }
      end

      context "should be valid success response" do
        before do
          click_button I18n.t('submit')
        end
        it { expect(page).to have_selector('div.alert.alert-success') }
        it { expect(current_path).to eq(home_path) }
      end
    end
  end

  describe "edit action" do
    before do
      FactoryGirl.create(:entry, user: user, blog: blog)
      visit edit_entry_path(entry)
    end

    context "should display form" do
      it { expect(page).to have_content('Title') }
      it { expect(page).to have_content('Body') }
    end
  end
end
