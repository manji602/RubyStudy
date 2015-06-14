require 'rails_helper'

describe "Static pages" do
  context "Home page" do
    before { visit home_path }

    it "should have valid contents" do
      expect(page.title).to eq 'DailyReportBlog | Home'
    end
  end

  context "About page" do
    before { visit about_path }

    it "should have valid contents" do
      expect(page.title).to eq 'DailyReportBlog | About Us'
    end
  end
end
