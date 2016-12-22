class AddSaveGitToSnippets < ActiveRecord::Migration[5.0]
  def change
    add_column(:snippets, :gist_save, :boolean)
  end
end
