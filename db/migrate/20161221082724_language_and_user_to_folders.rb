class LanguageAndUserToFolders < ActiveRecord::Migration[5.0]
  def change
    add_column(:folders, :language, :string)
    add_column(:folders, :github_username, :string)

  end
end
