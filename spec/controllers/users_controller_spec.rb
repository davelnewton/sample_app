require 'spec_helper'

describe UsersController do
    render_views

    describe "POST 'create'" do
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
        end
    end

    describe "GET 'show'" do
        before(:each) do
            @user = Factory :user
        end

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

    describe "GET 'new'" do
        it "should be successful and have correct title" do
            get :new
            response.should be_success
            response.should have_selector('title', :content => ' | Sign up')
        end
    end

end
