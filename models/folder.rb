
class Folder < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_title,
                  :against => :name,
                  :using => {
                    :tsearch => {:prefix => true}
                  }
  has_many(:snippets)
  validates_uniqueness_of :name, scope: :language
end
