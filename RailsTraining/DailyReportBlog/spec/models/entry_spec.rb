require 'rails_helper'

RSpec.describe Entry, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    user.blog = Blog.create(title: "sample blog", description: "sample description")
    @entry = user.blog.entries.build(title: "sample title", body: "sample body")
  end

  it "should respond" do
    expect(@entry).to respond_to(:title)
    expect(@entry).to respond_to(:body)
    expect(@entry).to respond_to(:blog_id)
    expect(@entry).to respond_to(:user_id)
    expect(1).to eq(1)
  end

  describe "belong object is null" do
    context "user_id is null" do
      before { @entry.user_id = nil }
      it { expect(@entry).not_to be_valid }
    end

    context "blog_id is null" do
      before { @entry.blog_id = nil }
      it { expect(@entry).not_to be_valid }
    end
  end

  describe "entry associations" do
    context "when destroy user" do
      it "should destroy associated entries" do
        @entries = user.blog.entries.to_a
        user.destroy
        @entries.each do |entry|
          expect(Entry.where(id: entry.id)).to be_empty
        end
      end
    end

    context "when destroy blog" do
      it "should destroy associated entries" do
        @entries = user.blog.entries.to_a
        user.blog.destroy
        @entries.each do |entry|
          expect(Entry.where(id: entry.id)).to be_empty
        end
      end
    end
  end

  describe "check validation" do
    shared_examples_for "invalid arguments" do
      it { expect(@entry).not_to be_valid }
    end

    context "title is nil" do
      before { @entry.title = nil }
      it_behaves_like "invalid arguments"
    end

    context "title is too long" do
      before { @entry.title = "a" * 101 }
      it_behaves_like "invalid arguments"
    end

    context "body is nil" do
      before { @entry.body = nil }
      it_behaves_like "invalid arguments"
    end

    context "body is too long" do
      before { @entry.body = "a" * 3001 }
      it_behaves_like "invalid arguments"
    end
  end
end
