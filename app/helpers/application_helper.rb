module ApplicationHelper

    def title
        t = 'Ruby on Rails Tutorial Sample App'
        return @title ? "#{t} | #{@title}" : t
    end

end
