require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit home_path }

    it { should have_content('Sample App') }
    it { should have_title('DailyReportBlog | Home') }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About Us') }
    it { should have_title('DailyReportBlog | About Us') }
  end

end
