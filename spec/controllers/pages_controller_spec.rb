require 'spec_helper'

describe PagesController do
    render_views

    describe "GET 'home'" do
        it "should be successful and have correct title" do
            get 'home'
            response.should be_success
            response.should have_selector('title', :content => ' | Home')
        end
    end

    describe "GET 'contact'" do
        it "should be successful and have correct title" do
            get 'contact'
            response.should be_success
            response.should have_selector('title', :content => ' | Contact')
        end
    end

    describe "GET 'about'" do
        it "should be successful and have correct title" do
            get 'about'
            response.should be_success
            response.should have_selector('title', :content => ' | About')
        end
    end

    describe "GET 'notitle'" do
        it "should be successful and have correct title" do
            get 'notitle'
            response.should be_success
            response.should have_selector('title', :content => 'Ruby on Rails Tutorial Sample App')
        end
    end

end
