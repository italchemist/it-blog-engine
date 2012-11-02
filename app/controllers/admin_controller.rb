class AdminController < ApplicationController
  def update
    UpdateLogics.update(Settings.git_path)
  end
end
