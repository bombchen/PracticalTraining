class UserReportUnit
  attr_accessor :user, :portfolio

  def initialize(user)
    @user = user
    @portfolio = Hash.new
  end
end