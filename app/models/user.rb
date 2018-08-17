class User < ApplicationRecord
    #downcase email before saving
    before_save { self.email = email.downcase }
    #this validates the user's name and makes sure it is there i.e. not a bunch of spaces, or nothing at all
    validates :name, presence: true, length: { maximum: 50 }
    #same thing but also uses a common regex
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
        format: { with: VALID_EMAIL_REGEX },
        uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    
end
