require('spec_helper')

describe Folder do
  describe '#snippets' do
    it "returns and array of all the snippets in the folder" do
      test_folder = Folder.create(:name => "Ruby")
      test_folder1 = test_folder.snippets.new({title: "Snippet_text"})
      test_folder2 = test_folder.snippets.new({title: "Snippet_text2"})
      expect(test_folder.snippets).to eq [test_folder1, test_folder2]
    end

  end

end
