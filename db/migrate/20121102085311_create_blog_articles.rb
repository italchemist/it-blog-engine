class CreateBlogArticles < ActiveRecord::Migration
  def change
    create_table :blog_articles do |t|
      t.references :article
    end
    add_index :blog_articles, :article_id
  end
end
