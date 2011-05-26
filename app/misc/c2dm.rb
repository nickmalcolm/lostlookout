require 'net/http'
require 'net/https'
class C2dm
  
  USERNAME = 'm20_kqLdSbqTIXL5Yfr7Ng'
  SECRET = 'cH-nXj8sQ2eJlRBJuMnYLQ'
  
  BASE_API_URL = "https://go.urbanairship.com/api/"
  BROADCAST_URL = "push/broadcast/"
  
  def self.deliver!
    
    headers = { "Content-Type" => "application/json"}
    url = URI.parse(BASE_API_URL+@uri)
    
    #Make the request
    post = Net::HTTP::Post.new(url.path, headers)
    post.basic_auth(USERNAME,SECRET)
    post.body = @data.to_json
    
    #Send it
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    res = http.start {|http| http.request(post) }
  end
    
  def self.broadcast(message)
    #Make it
    @uri = BROADCAST_URL
    @data = {"android" => {"alert" => message.to_s}}
    self.deliver!
  end
  
end