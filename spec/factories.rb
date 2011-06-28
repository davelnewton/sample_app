Factory.define :user do |user|
    user.name "Dave Newton"
    user.email "davelnewton@gmail.com"
    user.password "foobar"
    user.password_confirmation "foobar"
end

Factory.define :micropost do |mp|
    mp.content "Factory Girl-generated micropost content"
    mp.association :user
end
