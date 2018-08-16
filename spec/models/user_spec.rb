require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  subject { user }

  it { is_expected.to respond_to(:username) }
  it { is_expected.to respond_to(:email) }

  describe "when name is not present" do
    before { user.username = " " }

    it { is_expected.to be_invalid }
  end

  describe "when password is shot" do
    before { user.password = "12345" }

    it { is_expected.to be_invalid }
  end

  describe "when email format is invalid" do
    let(:addresses)do
      %w[user@foo,com user_at_foo.org example.user@foo.
                   foo@bar_baz.com foobar+baz.@com]
    end

    it "should be invalid" do
      addresses.each do |invalid_address|
        user.email = invalid_address

        is_expected.to be_invalid
      end
    end
  end

  describe "when email format is valid" do
    let(:addresses) { %w[vtstepura@gmail.com] }

    it "should be valid" do
      addresses.each do |valid_address|
        subject.email = valid_address
        is_expected.to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    let(:user_with_the_same_email) { user.dup }

    before { user_with_the_same_email.save }

     it { is_expected.to be_invalid }
  end
end
