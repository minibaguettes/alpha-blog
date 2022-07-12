class User < ApplicationRecord
  # ensures username/email is present before user object is saved to database
  # uniqueness: true => checks for case sensitivity by default, but don't want that, so specify case
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 } 
  # check for valid email by using regex as a constant 
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 105 }, format: { with:VALID_EMAIL_REGEX } 
  
end