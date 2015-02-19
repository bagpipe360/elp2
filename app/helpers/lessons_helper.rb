module LessonsHelper
    def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block)}
    uri = URI.parse("http://steady-box-12-181649.use1-2.nitrousbox.com:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  
end
