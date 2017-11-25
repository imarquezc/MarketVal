class Tag < ApplicationRecord
    belongs_to :product, optional: true
    belongs_to :image
end
