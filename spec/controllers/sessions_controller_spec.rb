require 'spec_helper'

describe SessionsController do
    render_views

    describe "GET 'new'" do
        it "should be successful and have the correct title" do
            get :new
            response.should be_success
            response.should have_selector("title", :content => 'Sign in')
        end
    end

    describe "POST 'create' (signin submission)" do
        describe "invalid signin" do
            before(:each) do
                @attr = { :email => 'email@example.com', :password => 'nobodies_password' }
            end

            it "should re-render the 'new' page and have the correct title" do
                post :create, :session => @attr
                response.should render_template('new')
                response.should have_selector("title", :content => 'Sign in')
            end

            it "should show a flash.now signin failure messasge" do
                post :create, :session => @attr
                flash.now[:error].should =~ /invalid/i
            end
        end

        describe "valid signin" do
            before(:each) do
                @user = Factory(:user)
                @attr = { :email => @user.email, :password => @user.password }
            end

            it "should sign the user in" do
                post :create, :session => @attr
                controller.current_user.should == @user
                controller.should be_signed_in
            end

            it "should redirect to the user show page (for that user)" do
                post :create, :session => @attr
                response.should redirect_to(user_path(@user))
            end
        end
    end
end
