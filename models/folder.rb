
class Folder < ActiveRecord::Base
  has_many(:snippets)
end
