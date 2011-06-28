require 'digest'

class User < ActiveRecord::Base

    attr_accessor :password # TODO "Virtual" attribute
    attr_accessible :name, :email, :password, :password_confirmation

    has_many :microposts

    email_regex = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

    validates :name, :presence => true, :length => { :maximum => 50 }
    validates :email, :presence => true,
                      :format => { :with => email_regex },
                      :uniqueness => { :case_sensitive => false }
    validates :password, :presence => true,
                         :confirmation => true, # TODO Creates password_confirmation
                         :length => { :within => 6..40 }

    before_save :encrypt_password

    def has_password?(unencrypted_password)
        encrypted_password == encrypt(unencrypted_password)
    end

    def self.authenticate(email, unencrypted_password)
        u = find_by_email(email)
        return nil if u.nil?
        return u.has_password?(unencrypted_password) ? u : nil
    end

    def self.authenticate_with_salt(id, cookie_salt)
        user = find_by_id(id)
        return (user && user.salt == cookie_salt) ? user : nil
    end

    private

        def encrypt_password
            self.salt = make_salt if new_record?
            self.encrypted_password = encrypt(password)
        end

        # TODO Implement
        def encrypt(s)
            secure_hash "#{salt}--#{s}"
        end

        def make_salt
            secure_hash "#{Time.now.utc}--#{password}"
        end

        def secure_hash(s)
            Digest::SHA2.hexdigest s
        end
end

# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#
