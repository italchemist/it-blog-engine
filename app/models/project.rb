class Project < ActiveRecord::Base
  has_many :project_articles
  has_many :articles, :through => :project_articles

  attr_accessible :name, :permalink

  def to_param
    permalink
  end

  def description
    articles.first().content
  end
end
