class User < ApplicationRecord
    #this is the method that pairs with belongs_to in the submission model. it allows one user to be associated with multiple submissions
    has_many :submissions, dependent: :destroy
    
    #downcase email before saving
    #before_save is a special method used by ActiveRecord
    before_save { self.email = email.downcase }
    
    #this validates the user's name and makes sure it is there i.e. not a bunch of spaces, or nothing at all
    validates :name, presence: true, length: { maximum: 50 }
    
    #same thing but also uses a common regex
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
        format: { with: VALID_EMAIL_REGEX },
        uniqueness: { case_sensitive: false }
        
    #this is a whole massive part of the tutorial that sets up a bunch of security features including encrypting the passwords
    #should research this a lot more before i try to use it on my own
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    
    
    #i also have no idea what this does.
    def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
    end
end
