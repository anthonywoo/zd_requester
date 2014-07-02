module ZdRequester
  class TopicCommentConnection < ZdRequester::Connection

    def endpoint
      "/api/v2/topics"
    end

    def default_data
      {"topic" => {"title" => "ZDTopic #{Time.now}", "body" => "I was mass created :/"}}
    end

    def return_id(response)
      JSON.parse(response.body)["topic"]["id"]
    end

  end
end
