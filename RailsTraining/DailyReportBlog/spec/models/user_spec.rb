require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    @user = User.new(name: "Example User",
                     email: "user@example.com",
                     password: "foobar",
                     password_confirmation: "foobar")
  end

  it "should have properties" do
    expect(@user).to respond_to(:name)
    expect(@user).to respond_to(:email)
    expect(@user).to respond_to(:password_digest)
    expect(@user).to respond_to(:password)
    expect(@user).to respond_to(:password_confirmation)
    expect(@user).to respond_to(:remember_token)
    expect(@user).to respond_to(:authenticate)
    expect(@user).to respond_to(:admin)
    expect(@user).to be_valid
    expect(@user).not_to be_admin
  end

 describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { expect(@user).to be_admin }
  end

  shared_examples_for "invalid arguments" do
    it { expect(@user).not_to be_valid }
  end

  describe "when name is not present" do
    before { @user.name = " " }

    it_behaves_like "invalid arguments"
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }

    it_behaves_like "invalid arguments"
  end

  describe "when email is not present" do
    before { @user.email = " " }

    it_behaves_like "invalid arguments"
  end

  describe "when email format is invalid" do
    context "should be invalid" do
      before { @user.email = "user@foo,com" }

      it_behaves_like "invalid arguments"
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it_behaves_like "invalid arguments"
  end

  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                       password: "", password_confirmation: "")
    end

    it_behaves_like "invalid arguments"
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }

    it_behaves_like "invalid arguments"
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }

    it_behaves_like "invalid arguments"
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    context "with valid password" do
      it { expect(@user).to eq found_user.authenticate(@user.password) }
    end

    context "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { expect(@user).not_to eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_falsey }
    end
  end

  describe "remember token" do
    before { @user.save }
    it{ expect(@user.remember_token).not_to be_blank }
  end

end
