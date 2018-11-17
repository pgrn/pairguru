class ToplistsController < ApplicationController
  def user_toplist
    @top_users = UserToplistQuery.new.last_week
  end
end
