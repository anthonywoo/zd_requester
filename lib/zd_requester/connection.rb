require 'faraday'
require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'json'
require 'active_support/core_ext/hash'

module ZdRequester
  class Connection

    def initialize(url, user, pass, concurrency = 5)
      manager = Typhoeus::Hydra.new(max_concurrency: concurrency)
      @connection = Faraday.new(:url => url, :parallel_manager => manager) do |builder|
        builder.adapter :typhoeus
      end
      @connection.basic_auth(user, pass)
    end

    def multi_post(count, data = nil) #returns ids
      puts "post started"
      start = Time.now
      responses = []
      @connection.in_parallel do
        count.times do |i|
          json_data = default_data.deep_merge(data).to_json
          responses << post(json_data)
        end
      end
      puts "post done. #{Time.now - start} seconds to complete"

      responses.select! { |response| response.status == 201 }

      responses.map! do |response|
        return_id(response)
      end
    end


    def delete_all(ids) #ids: array of ids
      puts "delete started"
      start = Time.now
      @connection.in_parallel do
        ids.each do |id|
          delete(id)
        end
      end
      puts "delete done. #{Time.now - start} seconds to complete"
    end

    def delete(id)
      @connection.delete do |req|
        req.url "#{endpoint}/#{id}.json"
      end
    end

    def post(data)
      @connection.post do |req|
        req.url "#{endpoint}.json"
        req.headers["Content-Type"] = 'application/json'
        req.body = data
      end
    end

    def get 
      @connection.get "#{endpoint}.json"
    end

  end
end
