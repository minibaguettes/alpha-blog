class Article < ApplicationRecord
    belongs_to :user    # article belongs to singular user
    validates :title, presence: true, length: { minimum: 6, maximum: 100}   
    validates :description, presence: true, length: { minimum: 10, maximum: 300}
end