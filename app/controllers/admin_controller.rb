class AdminController < ApplicationController
  def update
    UpdateLogics.update_articles("/home/italchemist/Blog")
  end
end
