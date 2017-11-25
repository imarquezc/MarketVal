class Product < ApplicationRecord
    has_many :tags
    has_many :images
end
