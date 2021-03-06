require 'spec_helper'

describe UsersController do
    render_views

    describe "POST 'create' (sign up)" do
        describe "failure" do
            before(:each) do
                @attr = { :name => '', :email => '', :password => '', :password_confirmation => ''}
            end

            it "should not create a user" do
                lambda do
                    post :create, :user => @attr
                end.should_not change(User, :count)
            end

            it "should return to 'new' and have the right title" do
                post :create, :user => @attr
                response.should render_template('new')
                response.should have_selector('title', :content => ' | Sign up')
            end
        end

        describe "success" do
            before(:each) do
                @attr = {
                    :name => 'Dave Newton',
                    :email => 'davelnewton@gmail.com',
                    :password => 'foobar',
                    :password_confirmation => 'foobar'
                }
            end

            it "should create and save the user" do
                lambda do
                    post :create, :user => @attr
                end.should change(User, :count).by(1)
            end

            it "should redirect to the user show page" do
                post :create, :user => @attr
                response.should redirect_to(user_path(assigns(:user)))
            end

            it "should flash a welcome message" do
                post :create, :user => @attr
                flash[:success].should =~ /welcome to the sample app/i
                response.should redirect_to(user_path(assigns(:user)))
            end

            it "should automatically sign the user in" do
                post :create, :user => @attr
                controller.should be_signed_in
            end
        end
    end

    describe "GET 'show' (users/n)" do
        before(:each) do
            @user = Factory :user
        end

        describe "basic user profile page" do
            it "should be successful and have correct title" do
                get :show, :id => @user
                response.should be_success
                response.should have_selector('title', :content => @user.name)
            end

            it "should show the right user" do
                get :show, :id => @user
                assigns(:user).should == @user
            end

            it "should show the user's name" do
                get :show, :id => @user
                response.should have_selector('h1', :content => @user.name)
            end

            it "should show the user's profile image" do
                get :show, :id => @user
                response.should have_selector('h1>img', :class => 'gravatar')
            end
        end

        describe "user profile microposts" do
            it "should display the user's microposts" do
                mp1 = Factory(:micropost, :user => @user, :content => "Foo bar")
                mp2 = Factory(:micropost, :user => @user, :content => "Baz quux")
                get :show, :id => @user
                response.should have_selector("span.content", :content => mp1.content)
                response.should have_selector("span.content", :content => mp2.content)
            end
        end
    end


    describe "GET 'new'" do
        it "should be successful and have correct title" do
            get :new
            response.should be_success
            response.should have_selector('title', :content => ' | Sign up')
        end
    end

end
