require 'rails_helper'

RSpec.describe "CommentPages", type: :request do
  let(:owner_user) { FactoryGirl.create(:user, id: 1) }
  let(:viewer_user) { FactoryGirl.create(:user, id: 2) }

  before(:each) do
    sign_in owner_user
    owner_user.blog = Blog.create(title: "sample blog", description: "sample description", user_id: owner_user.id)
    Entry.create(title: "sample entry", body: "sample body", user_id: owner_user.id, blog_id: owner_user.blog.id)
  end

  describe "create action" do
    before { visit user_path(owner_user) }

    context "when display user_page" do
      it "should have comment area" do
        comment_form = find('.field')
        expect(comment_form).not_to be_nil
      end
    end

    describe "with invalid comment" do
      context "should display error" do
        before do
          click_button I18n.t('submit')
        end

        it { expect(find('.alert-warning')).not_to be_nil }
      end
    end

    describe "with valid comment" do
      context "should create comment successfully" do
        before do
          fill_in 'comment[body]', with: "sample comment"
        end

        it "check action" do
          click_button I18n.t('submit')
          expect(find('.alert-success')).not_to be_nil
        end

        it "check comment data" do
          expect{ click_button I18n.t('submit') }.to change(Comment, :count).by(1)
        end
      end
    end
  end
end
