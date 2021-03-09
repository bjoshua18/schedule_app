if defined?(Mongoid)
  # GlobalID is used by ActiveJob (among other things)
  # https://github.com/rails/globalid

  Mongoid::Document.send(:include, GlobalID::Identification)
  Mongoid::Association::Proxy.send(:include, GlobalID::Identification)
end