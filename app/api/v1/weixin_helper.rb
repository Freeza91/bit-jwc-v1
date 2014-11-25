module V1
  module WeixinHelper

    include V1::Views::Weixin

    def text
      p @params
      text_reply "hello"
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

  end
end