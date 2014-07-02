module ZdRequester
  class TopicConnection < ZdRequester::Connection

    def endpoint
      "/api/v2/topics"
    end

    def default_data
      {"topic" => {"title" => "ZDTopic #{Time.now}", "body" => "I was mass created :/"}}
    end

    def return_id(response)
      JSON.parse(response.body)["topic"]["id"]
    end

    def valid_data?(data)
      if data["topic"].include? "forum_id"
        true
      else
        puts "you need to pass in forum_id. eg: {'topic' => {'forum_id' => id}}"
        false
      end
    end

  end
end
