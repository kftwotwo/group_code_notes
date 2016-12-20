require('spec_helper')

describe Folder do
  describe '#folders' do
    it "create a folder" do
      new_folder = Folder.create(:name => "HTML")
      expect(Folder.all).to eq [new_folder]
    end
    it "will check if to see if the folder has a snippet" do
      test_folder = Folder.create(:name => "HTML")
      test_snippet = Snippet.create(:title => "Divs", :content => "content", :tags => "tag", :github_username => "Josh", :language => "ruby", :folder_id => 1, :public => true)
      test_snippet2 = Snippet.create(:title => "Divs", :content => "content", :tags => "tag", :github_username => "Josh", :language => "ruby", :folder_id => 1, :public => true)
      expect(test_folder.snippets.push(test_snippet, test_snippet2)).to(eq(test_folder.snippets))
      expect(Snippet.all).to eq [test_snippet, test_snippet2]
    end
  end
end
