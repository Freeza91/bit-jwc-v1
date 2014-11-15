require 'grape-swagger'

module V1
  class API < Grape::API
    format :xml
    content_type :xml, "text/xml"
    version :v1

    get '/auth' do
      "hello"
    end

    get '/example' do
      #'<example>"example"<example>'
    end

    add_swagger_documentation mount_path: 'doc.xml', base_path: 'api', api_version: 'v1'
  end
end