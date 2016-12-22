class AddGistIdToSnippets < ActiveRecord::Migration[5.0]
  def change
    add_column(:snippets, :gist_id, :integer)
  end
end
