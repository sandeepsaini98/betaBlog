class User < ApplicationRecord
  has_secure_password

  class << self
    def create_new(inputs)
      user = User.new
      user.name = inputs['name']
      user.email = inputs['email']
      user.password = inputs['password']
      user.password_confirmation = inputs['password_confirmation']
      user.save!
  
      return { success: true, user: user}
    end
  end #__End of class << self
end #__End of class User
