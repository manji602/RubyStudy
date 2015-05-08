require 'spec_helper'

RSpec.describe "UserPages", type: :request do
  describe "User pages" do
    
    subject { page }

    describe "signup page" do
      before { visit signup_path }

      it { should have_content('Sign up') }
      it { should have_title('DailyReportBlog | Sign up') }
    end
  end
end
