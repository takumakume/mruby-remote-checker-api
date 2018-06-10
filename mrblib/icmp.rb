module RemoteChecker
  class ICMP < Base
    include RemoteChecker::L3

    def valid?
      c = ::FastRemoteCheck::ICMP.new(ipaddr, timeout)
      retryable { c.ping? }
    end
  end
end
