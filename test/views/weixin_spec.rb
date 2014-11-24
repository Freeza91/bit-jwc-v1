require 'net/http'

weixin = "http://localhost:3000/api/v1/auth.xml"
uri = URI weixin
req = Net::HTTP::Get.new(uri)
req['Content-Type'] = "text/xml;application/xml"
res = Net::HTTP.start(uri.hostname, uri.port) do |http|
  http.request req
end
p res.code
p res.body
