module ApplicationHelper

    def title
        t = 'Ruby on Rails Tutorial Sample App'
        return (@title.nil? || @title.strip.empty?) ? t : "#{t} | #{@title}"
    end

    def logo
        image_tag('logo.jpg', :alt => 'Sample App', :class => 'round')
    end

end
