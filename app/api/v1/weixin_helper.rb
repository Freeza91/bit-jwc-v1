module V1
  module WeixinHelper

    include V1::Views::Weixin
    include V1::TextHelper

    def text(content)
      res = \
        case content
        when /教+|室+/
          classroom_list
        when /课+|表+/
          schedule_list
        when /成+|绩+/
          grape_list
        when /通+|知+/
          news_list
        when /下+|学+|期+/
          next_schedule
        when /电+|话+/
          tel_list
        else
          help_infor
        end

        text_reply(res)
    end

    def image
    end

    def vocie
    end

    def video
    end

    def music
    end

    def article
    end

    def subscribe
      return "welcome to my weixin public account"
    end

    def unsubscribe
      p "delete weixin account"
      return "delete weixin account"
    end

  end
end