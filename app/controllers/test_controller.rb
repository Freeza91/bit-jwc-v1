class TestController < ApplicationController
  def index

    header = '<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" xmlns:d="http://www.w3.org/2001/XMLSchema" xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" xmlns:v="http://schemas.xmlsoap.org/soap/envelope/"><v:Header /><v:Body>'
    footer = '</v:Body></v:Envelope>'


    xml = Settings.header + Settings.study_status % {:student_num => "40689"} + Settings.footer
    path = Settings.key_post
    #res = init(path, xml)

    uri = URI Settings.host
    p Settings.host
    p uri
    http = Net::HTTP.new(uri.host, uri.port)
    header = {'Content-Type' => 'text/xml; charset=utf-8'}
    p xml
    p path
    p
    res = http.post(path, xml, header)
    p res
    render :text => "#{res.body}"
  end
end
