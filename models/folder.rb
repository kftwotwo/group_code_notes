
class Folder < ActiveRecord::Base
  has_many(:snippets)
  validates_uniqueness_of :name, scope: :language
end
