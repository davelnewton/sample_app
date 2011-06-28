require 'spec_helper'

describe Micropost do

    before(:each) do
        @user = Factory(:user)
        @attr = { :content => 'Micropost rspec content' }
    end

    describe "validations" do
        it "should require a user id" do
            Micropost.new(@attr).should_not be_valid
        end

        it "should require non-blank, non-nil content" do
            Micropost.new(@attr.merge(:content => nil)).should_not be_valid
            Micropost.new(@attr.merge(:content => '')).should_not be_valid
            Micropost.new(@attr.merge(:content => '   ')).should_not be_valid
        end

        it "should reject content that's too long" do
            Micropost.new(@attr.merge(:content => 'o'*141)).should_not be_valid
        end
    end

    describe "user associations" do
        before(:each) do
            @micropost = @user.microposts.create(@attr)
        end

        it "should have a user attribute" do
            @micropost.should respond_to(:user)
        end

        it "should have the correct user associated with it" do
            @micropost.user.should == @user
            @micropost.user_id.should == @user.id
        end
    end

end
