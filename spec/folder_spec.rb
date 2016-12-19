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
describe%20Folder%20do%0A%20%20describe%20'%23folders'%20do%0A%20%20%20%20it%20%22create%20a%20folder%22%20do%0A%20%20%20%20%20%20new_folder%20%3D%20Folder.create(%3Aname%20%3D%3E%20%22HTML%22)%0A%20%20%20%20%20%20expect(Folder.all).to%20eq%20%5Bnew_folder%5D%0A%20%20%20%20end%0A%20%20%20%20it%20%22will%20check%20if%20to%20see%20if%20the%20folder%20has%20a%20snippet%22%20do%0A%20%20%20%20%20%20test_folder%20%3D%20Folder.create(%3Aname%20%3D%3E%20%22HTML%22)%0A%20%20%20%20%20%20test_snippet%20%3D%20Snippet.create(%3Atitle%20%3D%3E%20%22Divs%22%2C%20%3Acontent%20%3D%3E%20%22content%22%2C%20%3Atags%20%3D%3E%20%22tag%22%2C%20%3Agithub_username%20%3D%3E%20%22Josh%22%2C%20%3Alanguage%20%3D%3E%20%22ruby%22%2C%20%3Afolder_id%20%3D%3E%201%2C%20%3Apublic%20%3D%3E%20true)%0A%20%20%20%20%20%20test_snippet2%20%3D%20Snippet.create(%3Atitle%20%3D%3E%20%22Divs%22%2C%20%3Acontent%20%3D%3E%20%22content%22%2C%20%3Atags%20%3D%3E%20%22tag%22%2C%20%3Agithub_username%20%3D%3E%20%22Josh%22%2C%20%3Alanguage%20%3D%3E%20%22ruby%22%2C%20%3Afolder_id%20%3D%3E%201%2C%20%3Apublic%20%3D%3E%20true)%0A%20%20%20%20%20%20expect(test_folder.snippets.push(test_snippet%2C%20test_snippet2)).to(eq(test_folder.snippets))%0A%20%20%20%20%20%20expect(Snippet.all).to%20eq%20%5Btest_snippet%2C%20test_snippet2%5D%0A%20%20%20%20end%0A%20%20end%0Aend%0A
