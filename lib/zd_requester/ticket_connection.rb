module ZdRequester
  class TicketConnection < ZdRequester::Connection

    def endpoint
      "/api/v2/tickets"
    end

    def default_data
      {"ticket" => {"subject" => "MultiTicket #{Time.now}", "comment" => { "body" => "Faraday" }}}.to_json
    end

    def return_id(response)
      JSON.parse(response.body)["ticket"]["id"]
    end

  end
end
