module Auth  
  
  def get_access_token(code, callback_url = ApiCallback)
    uri = URI.parse("https://auth.tfoundry.com")

    http = ::Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER 
    http.ca_file = '/usr/lib/ssl/certs/ca-certificates.crt'
    
    req = ::Net::HTTP::Post.new("/oauth/token")
    req.body = "client_id=#{ApiKey}&client_secret=#{ApiSecret}&redirect_uri=#{callback_url}&grant_type=authorization_code&code=#{code}"
    response = http.start {|htt| htt.request(req)}    

    JSON.parse(response.body)
  end
  
end