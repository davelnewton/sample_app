require 'spec_helper'

describe UsersController do
    render_views

    describe "GET 'show'" do
        before :each do
            @user = Factory :user
        end

        it "should be successful and have correct title" do
            get 'new'
            response.should be_success
        end

        it "should show the right user" do
            get :show, :id => @user
            assigns(:user).should == @user
        end
    end

    describe "GET 'new'" do
        it "should be successful and have correct title" do
            get 'new'
            response.should be_success
            response.should have_selector('title', :content => ' | Sign up')
        end
    end

end
