class Article < ApplicationRecord
    validates :title, presence: true, length: { minimum: 6, maximum: 100}   # constraint, title can't be empty, must be within 6 - 100 char 
    validates :description, presence: true, length: { minimum: 10, maximum: 300}
end