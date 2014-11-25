module V1
  module WeixinHelper

    include V1::Views::Weixin
    include V1::TextHelper

    def text(content)
      res = \
        case content
        when "教室"
          classroom_list
        when "课表"
          schedule_list
        when "成绩"
          grape_list
        when "通知"
          news_list
        when "下学期"
          next_schedule
        when "电话"
          tel_list
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