class AddImageToTag < ActiveRecord::Migration[5.1]
  def change
    add_reference :tags, :image, foreign_key: true
  end
end
