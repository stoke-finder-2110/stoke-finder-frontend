class UserFacade
  def self.all_users
    json = UserService.all_users
    binding.pry
    json[:data].map do |user|
      User.new(user)
    end
  end

  def self.user_info(user_id)
    json = UserService.user_info(user_id)
  
    User.new(json[:data])
  end

  # def self.user_create
  #   json = UserService.user_create
  #   binding.pry
  #   User.new(json[:data])
  # end

  # def self.user_adventures(user_id)
  #   json = UserService.user_adventures(user_id)
  #   json[:data].map do |adventure|
  #     Adventure.new(adventure)
  #   end
  # end
end