assert("RemoteChecker::ICMP#valid?") do
  url = "http://localhost/?ipaddr=172.0.0.0"
  assert_raise(RuntimeError) do
    RemoteChecker::ICMP.new(url).valid?
  end

  url = "http://localhost/?ipaddr=8.8.8.8"
  assert_true(RemoteChecker::ICMP.new(url).valid?)
end
