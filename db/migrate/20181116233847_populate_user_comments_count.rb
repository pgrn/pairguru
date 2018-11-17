class PopulateUserCommentsCount < ActiveRecord::Migration[5.2]
  def change
    User.all.each do |u|
      User.reset_counters(u.id, :comments)
    end
  end
end