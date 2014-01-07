module ZdRequester
  class MacroConnection < ZdRequester::Connection

    def endpoint
      "/api/v2/macros"
    end

    def default_data
      {"macro" => {"title" => "Roger Macro #{rand(1000)}", "actions" => [{"field" => "status", "value" => "solved"}]}}
    end

    def return_id(response)
      JSON.parse(response.body)["macro"]["id"]
    end

  end
end
