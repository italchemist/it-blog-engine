class CreateProjectArticles < ActiveRecord::Migration
  def change
    create_table :project_articles do |t|
      t.references :project
      t.references :article
    end
    add_index :project_articles, :project_id
    add_index :project_articles, :article_id
  end
end
