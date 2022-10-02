class UserContext
  attr_reader :user, :pincode, :cookies

  def initialize(user, pincode, cookies)
    @user = user
    @pincode = pincode
    @cookies = cookies
  end
end
