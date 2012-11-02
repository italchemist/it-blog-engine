class Article < ActiveRecord::Base
  has_many :project_articles
  has_many :projects, :through => :project_articles

  has_many :blog_articles

  attr_accessible :content, :title
  default_scope order('date DESC')

  def to_param
    permalink
  end
end
