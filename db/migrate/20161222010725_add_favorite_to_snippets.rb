class AddFavoriteToSnippets < ActiveRecord::Migration[5.0]
  def change
    add_column(:snippets, :favorite, :boolean)
  end
end
