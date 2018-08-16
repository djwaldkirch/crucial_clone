class User < ApplicationRecord
    #this validates the user's name and makes sure it is there i.e. not a bunch of spaces, or nothing at all
    validates :name, presence: true, length: { maximum: 50 }
    #same thing but with email
    validates :email, presence: true, length: { maximum: 255 }
end
