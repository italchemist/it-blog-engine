class AdminController < ApplicationController
  def update
    UpdateLogics.update_articles(Settings.git_path)
  end
end
