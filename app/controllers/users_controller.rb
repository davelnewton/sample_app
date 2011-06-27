class UsersController < ApplicationController

    def create
        @user = User.new(params[:user])
        if @user.save
            # TODO Implement.
        else
            @title = "Sign up"
            render 'new'
        end
    end

    def new
        @user = User.new
        @title = "Sign up"
    end

    def show
        @user = User.find(params[:id])
        @title = @user.name
    end

end
