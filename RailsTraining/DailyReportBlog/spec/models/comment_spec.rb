require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryGirl.create(:user, id: 1) }
  let(:blog) { FactoryGirl.create(:blog, user: user) }
  let(:entry) { FactoryGirl.create(:entry, user: user, blog: blog) }

  before(:each) do
    @comment = entry.comments.build(body: "sample body", user_id: user.id)
  end

  it "should respond" do
    expect(@comment).to respond_to(:body)
    expect(@comment).to respond_to(:entry_id)
    expect(@comment).to respond_to(:user_id)
    expect(@comment).to be_valid
  end

  describe "belong object is null" do
    context "user_id is null" do
      before { @comment.user_id = nil }
      it { expect(@comment).not_to be_valid }
    end

    context "blog_id is null" do
      before { @comment.entry_id = nil }
      it { expect(@comment).not_to be_valid }
    end
  end

  describe "entry associations" do
    context "when destroy user" do
      it "should destroy associated comments" do
        @comments = entry.comments.to_a
        user.destroy
        @comments.each do |comment|
          expect(Comment.where(id: comment.id)).to be_empty
        end
      end
    end

    context "when destroy blog" do
      it "should destroy associated comments" do
        @comments = entry.comments.to_a
        user.blog.destroy
        @comments.each do |comment|
          expect(Comment.where(id: comment.id)).to be_empty
        end
      end
    end

    context "when destroy entry" do
      it "should destroy associated comments" do
        @comments = entry.comments.to_a
        entry.destroy
        @comments.each do |comment|
          expect(Comment.where(id: comment.id)).to be_empty
        end
      end
    end
  end

  describe "check validation" do
    shared_examples_for "invalid arguments" do
      it { expect(@comment).not_to be_valid }
    end

    context "body is nil" do
      before { @comment.body = nil }
      it_behaves_like "invalid arguments"
    end

    context "body is too long" do
      before { @comment.body = "a" * 1001 }
      it_behaves_like "invalid arguments"
    end
  end

end
