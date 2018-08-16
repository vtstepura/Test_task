require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = User.new(username: "Example User", email: "user@example.com", password: 'school24') }

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }

  describe "when name is not present" do
    before { @user.username = " " }
    it { should_not be_valid }
  end

  describe "when password is shot" do
    before { @user.password = "12345" }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foobar+baz.@com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[vtstepura@gmail.com]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
end
