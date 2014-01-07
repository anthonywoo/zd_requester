module ZdRequester
  class UserConnection < ZdRequester::Connection

    def endpoint
      "/api/v2/users"
    end

    def default_data
      {"user" => {"name" => "Roger Wilco", "email" => "roge#{rand(10000000)}@example.orz"}}
    end

    def return_id(response)
      JSON.parse(response.body)["user"]["id"]
    end

  end
end
