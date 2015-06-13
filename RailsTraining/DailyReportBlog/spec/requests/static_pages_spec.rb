require 'rails_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit home_path }

    it "should have valid contents" do
      expect(page).to have_content('Home')
      expect(page).to have_title('DailyReportBlog | Home')
    end
  end

  describe "About page" do
    before { visit about_path }

    it "should have valid contents" do
      expect(page).to have_content('Abount Us')
      expect(page).to have_title('DailyReportBlog | Abount Us')
    end
  end
end
