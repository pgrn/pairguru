class UserToplistQuery
  attr_reader :relation

  def initialize(users = User.all)
    @users = users
  end

  def last_week
    @users
      .joins(:comments)
      .where(comments: { created_at: 7.days.ago..Time.now })
      .group(:id)
      .order(comments_count: :desc)
      .limit(10)
      .all
  end
end