# frozen_string_literal: true

module Caspio
  class CaspioQuery < Token

    URL = 'http://127.0.0.1:5000/'

    def get(source_type, source, transform_row_func, query=nil)
      result = {
        success: true,
        data: nil,
        status: 200
      }
      # token = get_token
      token = JSON.parse('{"token_type": "Bearer", "access_token": "test"}', object_class: OpenStruct)
      header = {
        'Authorization' => "#{token.token_type} #{token.access_token}"
      }
      page = 1
      data = []
      if query
        query = '&' + query
      end
      # p header
      # p "https://#{BRIDGE}.caspio.com/rest/v2/#{source_type}s/#{source}/records?response=rows?q.pageNumber=#{page}&q.pageSize=1000#{query}"
      loop do
        resp = RestClient.get(
          "#{URL}#{source_type}s/#{source}/records?response=rows?q.pageNumber=#{page}&q.pageSize=1000#{query}",
          header
        )
        if 200 <= resp.code and resp.code <= 299
          rows = JSON.parse(resp.body, object_class: OpenStruct)
          rows.Result.each do |row|
            # p transform_row_func.call(row)
            data << transform_row_func.call(row)
          end
          break if rows.Result.count < 1000
          page += 1
        end
        if resp.code >= 300
          result[:success] = false
          result[:status] = resp.code
          break
        end
      end
      result[:data] = data
      result
    end

    def create(source_type, source, insert_data)
      result = {
        success: false,
        data: nil,
        status: 500
      }
      # token = get_token
      token = JSON.parse('{"token_type": "Bearer", "access_token": "test"}', object_class: OpenStruct)
      header = {
        'Authorization' => "#{token.token_type} #{token.access_token}",
        'Content-Type' => "application/json"
      }
      p '___________'
      p "#{URL}rest/v2/#{source_type}s/#{source}/records?response=rows"
      p insert_data.to_json
      p header
      resp = RestClient.post(
        "#{URL}rest/v2/#{source_type}s/#{source}/records?response=rows",
        insert_data.to_json,
        header
      )
      if 200 <= resp.code and resp.code < 300
        result[:data] = JSON.parse(resp.body, object_class: OpenStruct)
        result[:success] = true
        result[:status] = resp.code
      end
      p result[:status], result[:data]
      result
    end

    def update(source_type, source, insert_data, query=nil)
      result = {
        success: false,
        data: nil,
        status: 500
      }
      # token = get_token
      token = JSON.parse('{"token_type": "Bearer", "access_token": "test"}', object_class: OpenStruct)
      header = {
        'Authorization' => "#{token.token_type} #{token.access_token}",
        'Content-Type' => "application/json"
      }
      if query
        query = '&' + query
      end
      p "https://#{BRIDGE}.caspio.com/rest/v2/#{source_type}s/#{source}/records?response=rows&#{query}"
      p '___________'
      p "https://#{BRIDGE}.caspio.com/rest/v2/#{source_type}s/#{source}/records?response=rows"
      p insert_data.to_json
      p header
      resp = RestClient.put(
        "#{URL}rest/v2/#{source_type}s/#{source}/records?response=rows&#{query}",
        insert_data.to_json,
        header
      )
      if resp.code == 200
        result[:success] = true
      end
      result
    end
  end
end