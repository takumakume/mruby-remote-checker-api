assert("RemoteChecker::Port#valid?") do
  url = "http://localhost/?ipaddr=8.8.8.8&port=1111"
  assert_raise(RuntimeError) do
    RemoteChecker::Port.new(url).valid?
  end

  url = "http://localhost/?ipaddr=8.8.8.8&port=53"
  assert_true(RemoteChecker::Port.new(url).valid?)
end
