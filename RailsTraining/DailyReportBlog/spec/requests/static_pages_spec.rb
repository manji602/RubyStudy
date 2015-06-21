require 'rails_helper'

describe "Static pages" do
  let(:user) { FactoryGirl.create(:user) }
  describe "Home page" do
    before { visit home_path }

    it "should have valid contents" do
      expect(page.title).to eq "DailyReportBlog | #{I18n.t('home')}"
    end
  end

  describe "About page" do
    before { visit about_path }

    it "should have valid contents" do
      expect(page.title).to eq "DailyReportBlog | #{I18n.t('about')}"
    end
  end

  describe "Setting page" do
    describe "blog destruction" do
      before do
        sign_in user
        FactoryGirl.create(:blog, user: user)
        visit settings_path
      end

      it "should delete a blog" do
        expect { click_link I18n.t('delete_blog') }.to change(Blog, :count).by(-1)
      end
    end
  end
end
