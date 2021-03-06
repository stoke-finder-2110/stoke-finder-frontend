class UserService

  def self.user_info(user_id)
    response = conn.get("/api/v1/users/#{user_id}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.user_create(attributes)
    response = conn.post("/api/v1/users", attributes.to_json, "CONTENT_TYPE" => "application/json")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.user_update(attributes, session_user_id)
    response = conn.patch("/api/v1/users/#{session_user_id}", attributes.to_json, "CONTENT_TYPE" => "application/json")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.user_delete(session_user_id)
   response = conn.delete("/api/v1/users/#{session_user_id}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.login_user(user_data)
    response = conn.post("/api/v1/sessions", user_data.to_json, "CONTENT_TYPE" => "application/json")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.oauth_find(user_data)
    response = conn.post("/api/v1/sessions/auth", user_data.to_json, "CONTENT_TYPE" => "application/json")
    JSON.parse(response.body, symbolize_names: true)
  end

  # def self.user_adventures(user_id)
  #   response = conn.get("/api/v1/users/#{user_id}/adventures")
  #   JSON.parse(response.body, symbolize_names: true)
  # end

  def self.conn
    Faraday.new("https://arcane-sands-07034.herokuapp.com")
  end
end
