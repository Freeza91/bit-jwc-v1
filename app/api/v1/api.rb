require 'grape-swagger'

module V1
  class API < Grape::API
    format :txt #https://ruby-china.org/topics/11407
    version :v1

    helpers V1::WeixinHelper

    before do #http://mp.weixin.qq.com/wiki/index.php?title=%E9%AA%8C%E8%AF%81%E6%B6%88%E6%81%AF%E7%9C%9F%E5%AE%9E%E6%80%A7
      if request.get?
        timestamp, nonce = params[:timestamp].to_s, params[:nonce].to_s
        codes = ["jwcbit", timestamp, nonce].sort.join("")
        error!('401 Unauthorized', 401) unless Digest::SHA1.hexdigest(codes) == params[:signature]
      end
      status(200)
    end

    get '/' do
      params['echostr']
    end

    get '/text' do
      #http://localhost:8080/api/v1?
      #signature=9957b6ad3a6ca36a8469e0d3f121cac5e4eacf39&echostr=75661286dsds49082288830&timestamp=1416899262&nonce=852791110
      text
    end

    post '/' do
      @params = Hash.from_xml(request.body.read)['xml']
      text
    end

    #add_swagger_documentation mount_path: 'doc.xml', base_path: 'api', api_version: 'v1'
  end
end