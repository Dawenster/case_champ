class Kellogg::User

  BASE_URL = "https://api.kellogg.northwestern.edu/API"

  def self.login(username, password)
    kellogg_token = create_token_for_kellogg(username, password)
    create_token_for_nu(username, kellogg_token)
  end

  def self.create_token_for_kellogg(username, password)
    url = "#{BASE_URL}/KelloggWebSSOService/api/kelloggToken/authenticate"
    body = {
      username: username,
      password: password
    }
    response = RestClient.post url, body.to_json, { content_type: :json, accept: :json }
    response.body[1..-10]
  rescue => e
    Rollbar.error(e, username: username)
  end

  def self.create_token_for_nu(username, kellogg_token)
    url = "#{BASE_URL}/KelloggWebSSOService/api/kelloggToken/createTokenForNU"
    body = {
      username: username,
      token: kellogg_token
    }
    response = RestClient.post url, body.to_json, { content_type: :json, accept: :json }
    response.body[1..-2]
  rescue => e
    Rollbar.error(e, username: username)
  end

  def self.get_netid(nu_token)
    url = "#{BASE_URL}/KelloggWebSSOService/api/kelloggToken/GetUserNetIDPHP?token=#{nu_token}"
    response = RestClient.post url, {}, { content_type: :json, accept: :json }
    response.body
  rescue => e
    Rollbar.error(e)
  end

  def self.validate_nu_token(nu_token)
    url = "#{BASE_URL}/KelloggWebSSOService/api/kelloggToken/ValidateTokenPhp?token=#{nu_token}"
    response = RestClient.post url, {}, { content_type: :json, accept: :json }
    response.body == "true"
  rescue => e
    Rollbar.error(e)
  end

  def self.fetch_user_details(username)
    url = "#{BASE_URL}/KSMService/StudentProfile/#{username}"
    response = RestClient.get url
    JSON.parse(response.body).first
  rescue => e
    Rollbar.error(e)
  end

end
