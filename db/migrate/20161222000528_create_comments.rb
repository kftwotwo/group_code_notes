class CreateComments < ActiveRecord::Migration[5.0]
  def change
    add_column(:snippets, :comments, :text)
  end
end
