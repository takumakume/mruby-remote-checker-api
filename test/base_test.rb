URL_NO_QUERY = "http://localhost/"
URL_IPADDR_EMPTY = "http://localhost/?ipaddr="
URL = "http://localhost/?ipaddr=8.8.8.8&timeout=1&max_tries=2#z"
QUERIES = {
  "ipaddr"    => "8.8.8.8",
  "timeout"   => "1",
  "max_tries" => "2",
}

@tries = 0

def true_func
  @tries += 1
  true
end

def error_func
  @tries += 1
  raise RuntimeError, "test error"
end

module RemoteChecker
  class Test < Base
    def valid?
      true
    end
  end

  class TestRaise < Base
    def valid?
      raise "test error"
    end
  end
end

assert("RemoteChecker::Base") do
  assert_true(RemoteChecker::Base.is_a?(Class))
end

assert("RemoteChecker::Base#queries") do
  assert_raise(RuntimeError) do
    RemoteChecker::Base.new(URL_NO_QUERY).queries
  end

  assert_raise(RuntimeError) do
    RemoteChecker::Base.new(URL_IPADDR_EMPTY).queries
  end

  assert_equal(QUERIES, RemoteChecker::Base.new(URL).queries)
end

assert("RemoteChecker::Base#retryable") do
  @tries = 0
  assert_true(RemoteChecker::Base.new(URL).retryable{ true_func })
  assert_equal(1, @tries)

  @tries = 0
  assert_raise(RuntimeError, "test error") do
    RemoteChecker::Base.new(URL).retryable{ error_func }
  end
  assert_equal(2, @tries)
end

assert("RemoteChecker::Base#execute") do
  assert_equal('{"status":true,"error":""}', RemoteChecker::Test.new(URL).execute)
  assert_equal('{"status":false,"error":"test error"}', RemoteChecker::TestRaise.new(URL).execute)
end
