module RemoteChecker
  class Base
    def initialize(unparsed_uri)
      @uri = URI.parse(unparsed_uri)
    end

    def queries
      @_queries ||= URI.decode_www_form(@uri.query).to_h
    rescue => e
      raise RuntimeError, "query string parse error: #{e.message}"
    end


    def timeout
      queries.fetch("timeout", 3).to_f
    end

    def max_tries
      queries.fetch("max_tries", 3).to_i
    end

    def valid?
      raise NotImplementedError, "valid? is a required method"
    end

    def execute
      r = {
        status: false,
        error: "",
      }
      begin
        r[:status] = valid?
      rescue => e
        r[:status] = false
        r[:error] = e.message
      end
      r.to_json
    end
  
    def retryable(&block)
      tries = 0
      ret = nil
      begin
        ret = block.call
        raise unless ret
      rescue => e
        tries += 1
        retry if tries < max_tries 
        raise e
      end
      ret
    end
  end
end
