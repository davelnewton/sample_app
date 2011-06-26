module ApplicationHelper

    def title
        t = 'Ruby on Rails Tutorial Sample App'
        return (@title.nil? || @title.strip.empty?) ? t : "#{t} | #{@title}"
    end

end
