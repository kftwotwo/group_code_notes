require('spec_helper')

describe Snippet do
  it "will check if the tables are setup right" do
    new_snippet = Snippet.create(:title => "Divs", :content => "content", :tags => "tag", :github_username => "Josh", :language => "ruby", :folder_id => 1, :public => true)
    expect(Snippet.all).to eq [new_snippet]
  end
  it "tells you which folder it belongs to" do
    new_folder = Folder.create(:name => "HTML")
    new_snippet = Snippet.create(:title => "Divs", :content => "content", :tags => "tag", :github_username => "Josh", :language => "ruby", :folder_id => new_folder.id, :public => true)
    expect(new_snippet.folder).to eq new_folder
  end
end
