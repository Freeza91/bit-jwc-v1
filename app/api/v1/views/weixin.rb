require 'builder'

module V1
  module Views
    module Weixin

      def text_reply(content="")
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.root {
            xml.ToUserName    "<![CDATA[%s]]>" % params['FromUserName']
            xml.FromUserName  "<![CDATA[%s]]>" % params['ToUserName']
            xml.MsgType       "<![CDATA[%s]]>" % "text"
            xml.CreateTime    "<![CDATA[%d]]>" % Time.now.to_i
            xml.Content       "<![CDATA[%s]]>" % "content"
        }
        end
        builder.doc.root.children
      end

      def image_reply(media_id="")
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.root {
            xml.ToUserName    "<![CDATA[%s]]>" % params['FromUserName']
            xml.FromUserName  "<![CDATA[%s]]>" % params['ToUserName']
            xml.MsgType       "<![CDATA[%s]]>" % "image"
            xml.CreateTime    "<![CDATA[%d]]>" % Time.now.to_i
            xml.Image {
              xml.Media_id    "<![CDATA[%s]]>" % media_id
            }
          }
        end
        builder.doc.root.children
      end

      def vocie_reply(media_id="")
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.root {
            xml.ToUserName    "<![CDATA[%s]]>" % params['FromUserName']
            xml.FromUserName  "<![CDATA[%s]]>" % params['ToUserName']
            xml.MsgType       "<![CDATA[%s]]>" % "voice"
            xml.CreateTime    "<![CDATA[%d]]>" % Time.now.to_i
            xml.Voice {
              xml.Media_id    "<![CDATA[%s]]>" % media_id
            }
          }
        end
        builder.doc.root.children
      end

      def video_reply(media_id="", title="", description="")
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.root {
            xml.ToUserName    "<![CDATA[%s]]>" % params['FromUserName']
            xml.FromUserName  "<![CDATA[%s]]>" % params['ToUserName']
            xml.MsgType       "<![CDATA[%s]]>" % "video"
            xml.CreateTime    "<![CDATA[%d]]>" % Time.now.to_i
            xml.Video {
              xml.Media_id    "<![CDATA[%s]]>" % media_id
              xml.Title       "<![CDATA[%s]]>" % title
              xml.Description "<![CDATA[%s]]>" % description
            }
          }
        end
        builder.doc.root.children
      end

      def music_reply(title="", description="", musicurl="", hqmusicUrl="", thumbmediaId="")
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.root {
            xml.ToUserName    "<![CDATA[%s]]>" % params['FromUserName']
            xml.FromUserName  "<![CDATA[%s]]>" % params['ToUserName']
            xml.MsgType       "<![CDATA[%s]]>" % "music"
            xml.CreateTime    "<![CDATA[%d]]>" % Time.now.to_i
            xml.Music {
              xml.title       "<![CDATA[%s]]>" % title
              xml.Description "<![CDATA[%s]]>" % description
              xml.MusicUrl    "<![CDATA[%s]]>" % musicurl
              xml.HQMusicUrl  "<![CDATA[%s]]>" % hqmusicUrl
              xml.ThumbMediaId"<![CDATA[%s]]>" % thumbmediaId
            }
          }
        end
        builder.doc.root.children
      end

      def article_reply(num=0, title=[], description=[], picurl=[], url=[])
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.root {
            xml.ToUserName    "<![CDATA[%s]]>" % params['FromUserName']
            xml.FromUserName  "<![CDATA[%s]]>" % params['FromUserName']
            xml.MsgType       "<![CDATA[%s]]>" % "news"
            xml.CreateTime    "<![CDATA[%d]]>" % Time.now.to_i
            xml.ArticleCount  "<![CDATA[%d]]>" % num
            xml.Articles {
              1.upto(num) do |i|
                xml.item {
                  xml.Title       "<![CDATA[%s]]>" % title[i-1]
                  xml.Description "<![CDATA[%s]]>" % description[i-1]
                  xml.PicUrl      "<![CDATA[%s]]>" % picurl[i-1]
                  xml.Url         "<![CDATA[%s]]>" % url[i-1]
                }
              end
            }
          }
        end
        builder.doc.root.children
      end

    end
  end
end
