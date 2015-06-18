require 'rails_helper'

RSpec.describe Blog, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    user.blog = Blog.create(title: "sample blog", description: "sample description")
  end

  it "should respond" do
    expect(user.blog).to respond_to(:title)
    expect(user.blog).to respond_to(:description)
    expect(user.blog).to respond_to(:user_id)
  end

  describe "when user_id is null" do
    before { user.blog.user_id = nil }
    it { expect(user.blog).not_to be_valid }
  end

  describe "should destroy blog when destroy user" do
    before do
      user.destroy
    end

    it { expect(Blog.where(id: user.blog.id)).to be_empty }
  end

  describe "check validation" do
    shared_examples_for "invalid arguments" do
      it { expect(user.blog).not_to be_valid }
    end

    context "title is nil" do
      before { user.blog.title = nil }
      it_behaves_like "invalid arguments"
    end

    context "title is too long" do
      before { user.blog.title = "a" * 51 }
      it_behaves_like "invalid arguments"
    end

    context "description is nil" do
      before { user.blog.description = nil }
      it_behaves_like "invalid arguments"
    end

    context "description is too long" do
      before { user.blog.description = "a" * 501 }
      it_behaves_like "invalid arguments"
    end
  end

end
