require 'spec_helper'

describe User do

    before(:each) do
        @attr = { :name => 'Example User', :email => 'wtf@over.com' }
    end

    it "should create a new instance given valid attributes" do
        User.create!(@attr)
    end

    it "should require a name" do
        failure = User.new(@attr.merge(:name => ''))
        failure.should_not be_valid
    end

    it "should require an email" do
        failure = User.new(@attr.merge(:email => ''))
        failure.should_not be_valid
    end

    # TODO I'd like to keep the length in the User class--as a class var?
    it "should reject names that are too long" do
        failure = User.new(@attr.merge(:name => 'a'*51))
        failure.should_not be_valid
    end

    it "should accept valid email addresses" do
        valid_addrs = %w[user@foo.com WAT_WAT@nar.nar.nar first.last@long.subdomain]
        valid_addrs.each do |addr|
            user = User.new(@attr.merge({ :email => addr }))
            user.should be_valid
        end
    end

    it "should reject invalid email addresses" do
        bad_addrs = %w[not_email.addr missing_at_sign.org no@subdomain.]
        bad_addrs.each do |addr|
            user = User.new(@attr.merge({ :email => addr }))
            user.should_not be_valid
        end
    end

    it "should reject duplicate email addresses" do
        User.create!(@attr)
        user = User.new(@attr)
        user.should_not be_valid
    end

    it "should reject email addresses that differ only in upper/lower case" do
        uc_email = @attr[:email].upcase

        User.create!(@attr.merge({ :email => uc_email }))
        user = User.new(@attr)
        user.should_not be_valid
    end

end

# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#
