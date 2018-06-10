module RemoteChecker
  module L3
    def ipaddr
      hash_safe_read("ipaddr") rescue raise "ipaddr is a required param"
    end
  end
end
