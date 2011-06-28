require 'spec_helper'

describe Micropost do

    before(:each) do
        @user = Factory(:user)
        @attr = { :content => 'Micropost rspec content' }
    end

    it "should create a micropost when given valid attributes" do
        Micropost.create! @attr
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
