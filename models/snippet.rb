class Snippet < ActiveRecord::Base
  belongs_to(:folder)
  validates_presence_of :content
  validates_presence_of :github_username
end
