require 'grape-swagger'

module V1
  class API < Grape::API
    format :json
    version :v1

    get '/' do
      "hello"
    end

    get '/example' do
      "example"
    end

    add_swagger_documentation mount_path: 'doc.json', base_path: 'api', api_version: 'v1'
  end
end