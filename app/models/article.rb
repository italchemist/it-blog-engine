class Article < ActiveRecord::Base
  attr_accessible :content, :title
  default_scope order('date DESC')
end
