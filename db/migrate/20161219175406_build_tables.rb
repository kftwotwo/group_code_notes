class BuildTables < ActiveRecord::Migration[5.0]
  def change

    create_table(:folders) do |t|
      t.column(:name, :string)
    end

    create_table(:snippets) do |t|
      t.column(:title, :string)
      t.column(:content, :text)
      t.column(:tags, :string)
      t.column(:github_username, :string)
      t.column(:language, :string)
      t.column(:folder_id, :integer)
      t.column(:public, :boolean)
      t.timestamps
    end

  end
end
