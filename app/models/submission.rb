class Submission < ApplicationRecord
  #this is all of the attributes and restrictions placed on submission objects. submissions cannot be stored unless they pass all of these things
  
  #this allows multiple submissions to be associated with one user.
  #it is related to the has_many method in the user model - you need both for this to work
  belongs_to :user
  
  #this will order the submissions on the user profile feed. normally submission objects have no particular order and this forces it
  #in reading about this, it seems this may not be recommended. should research this more.
  default_scope -> { order(created_at: :desc) }
  
  #these are pretty straightforward validations that come from the params, which come from the forms
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :artist, presence: true, length: { maximum: 100 }
  validates :genre, presence: true, length: { maximum: 100 }
end
