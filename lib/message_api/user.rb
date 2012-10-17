module MessageApi
  class User  
    include Session

    def list
      response = client(:GET, "/a1/messages/messages/")
      response['count'] > 0 ? response['messages'].map{|msg| Message.new(msg) } : []
    end
    
    def create(receipt, content)
      post_params = {"recipient" => receipt, "text" => content}
      response = client(:POST, "/a1/messages/messages/", post_params)      
    end
    
    def delete(id)
      response = client(:DELETE, "/a1/messages/messages/#{id}")
    end
    
    def message(id)
      response = client(:GET, "/a1/messages/messages/#{id}")
      Message.new(response)
    end
    
  end
end