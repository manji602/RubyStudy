require 'rails_helper'

RSpec.describe "BlogPages", type: :request do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    sign_in user
  end

  describe "create action" do
    before { visit new_blog_path }

    context "should display form" do
      it { expect(page).to have_content('Title') }
      it { expect(page).to have_content('Description') }
    end

    context "with invalid information" do
      before { click_button I18n.t('create_blog') }
      it { expect(page).to have_content('error') }
    end

    describe "with valid information" do
      let(:blog_title) { "sample blog" }
      let(:blog_description) { "sample description" }
      before do
        fill_in 'Title', with: blog_title
        fill_in 'Description', with: blog_description
      end

      context "should create blog" do
        it { expect { click_button I18n.t('create_blog') }.to change(Blog, :count).by(1) }
      end

      context "should be valid success response" do
        before do
          click_button I18n.t('create_blog')
        end
        it { expect(page).to have_selector('div.alert.alert-success') }
        it { expect(current_path).to eq(home_path) }
      end
    end
  end

  describe "edit action" do
    before do
      FactoryGirl.create(:blog, user: user)
      visit edit_blog_path(user.blog)
    end

    context "should display form" do
      it { expect(page).to have_content('Title') }
      it { expect(page).to have_content('Description') }
    end

    context "with invalid information" do
      before do
        fill_in 'Title', with: "a" * 51
        fill_in 'Description', with: "sample description"
        click_button I18n.t('save_changes')
      end
      it { expect(page).to have_content('error') }
    end

    describe "with valid information" do
      let(:blog_title) { "sample blog" }
      let(:blog_description) { "sample description(edited)" }
      before do
        fill_in 'Title', with: blog_title
        fill_in 'Description', with: blog_description
      end

      context "should be valid success response" do
        before do
          click_button I18n.t('save_changes')
        end
        it { expect(page).to have_selector('div.alert.alert-success') }
        it { expect(current_path).to eq(home_path) }
      end
    end
  end
end
