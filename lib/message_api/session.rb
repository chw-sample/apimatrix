module MessageApi
  module Session
    
    require 'net/http'    

    def self.included(other)
      other.class_eval { attr_reader :token }
    end

    def initialize(token)
      @token = token
    end
    
    def client(method, path, params = {})
      uri = URI.parse("https://api.tfoundry.com/")

      http = ::Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER 
      http.ca_file = '/usr/lib/ssl/certs/ca-certificates.crt'
      
      target = "#{path}?access_token=#{@token}"
      
      req = case method
            when :POST
              ::Net::HTTP::Post.new(target)
            when :DELETE
              ::Net::HTTP::Delete.new(target)
            else
              ::Net::HTTP::Get.new(target)
            end
            
      req["Content-Type"] = "application/json"
      req.body = JSON.generate(params)

      response = http.start {|htt| htt.request(req)}
      
      JSON.parse(response.body)
    end
  end
end