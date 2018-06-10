module RemoteChecker
  module L4
    include RemoteChecker::L3

    def port
      hash_safe_read("port").to_i rescue raise "port is a required param"
    end
  end
end
