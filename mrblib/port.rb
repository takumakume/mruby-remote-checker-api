module RemoteChecker
  class Port < Base
    include RemoteChecker::L4

    def valid?
      c = ::FastRemoteCheck.new("127.0.0.1", 0, ipaddr, port, timeout)
      retryable { c.connectable? }
    end
  end
end
