class AddDescription < ActiveRecord::Migration[5.0]
  def change
    add_column(:snippets, :description, :text)
  end
end
