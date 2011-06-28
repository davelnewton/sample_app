require 'spec_helper'

describe "Users" do

    describe "signup" do
        describe "failure" do
            it "should not make a new user" do
                lambda do
                    visit signup_path
                    fill_in "Name", :with => ""
                    fill_in "Email", :with => ""
                    fill_in "Password", :with => ""
                    fill_in "Confirmation", :with => ""
                    click_button

                    response.should render_template('users/new')
                    response.should have_selector("div#error_explanation")
                end.should_not change(User, :count)
            end

            it "should clear the password fields" do
                visit signup_path
                fill_in "Name", :with => "Example User"
                fill_in "Email", :with => "" # Force form failure
                fill_in "Password", :with => "foobar"
                fill_in "Confirmation", :with => "foobar"
                click_button

                response.should render_template('users/new')
                response.should have_selector("div#error_explanation")

                field_labeled("Password").value.should == ""
                field_labeled("Confirmation").value.should == ""
            end
        end

        describe "success" do
            it "should make a new user" do
                lambda do
                    visit signup_path
                    fill_in "Name", :with => "Example User"
                    fill_in "Email", :with => "wtf@over.com"
                    fill_in "Password", :with => "foobar"
                    fill_in "Confirmation", :with => "foobar"
                    click_button

                    response.should render_template('users/show')
                end.should change(User, :count).by(1)
            end
        end
    end

    describe "sign in/out" do
        describe "failure" do
            it "should not sign the user in" do
                integration_sign_in(User.new)
                response.should have_selector('div.flash.error', :content => 'Invalid')
            end
        end

        describe "success" do
            it "should sign a user in, then out" do
                integration_sign_in(Factory(:user))
                controller.should be_signed_in
                click_link 'Sign out'
                controller.should_not be_signed_in
            end
        end
    end

end
