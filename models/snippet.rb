class Snippet < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_title_tags_content_description,
                  :against => [:title, :tags, :content, :description],
                  :using => {
                    :tsearch => {:prefix => true}
                  }
  belongs_to(:folder)
  validates_presence_of :content
  validates_presence_of :github_username
  validates :title, :uniqueness => { :case_sensitive => true }
end
