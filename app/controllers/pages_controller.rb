class PagesController < ApplicationController
    def home
        @title = 'Home'
    end

    def contact
        @title = 'Contact'
    end

    def about
        @title = 'About'
    end

    def help
        @title = 'Help'
    end

    # Currently just to test title helper.
    def notitle
        @title = '' # Oops.
    end
end
