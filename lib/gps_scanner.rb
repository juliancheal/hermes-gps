class GPSScanner
  def initialize(*args)
    @scanner = Hermes::GPS::Scanner.new(args)
    @scanner.async.scan(0.5)
  end

  def subscribe(topic, &block)
    obs = Hermes::GPS::Observer.new
    obs.subscriber(topic,&block)
  end

  def on_message(*args)
    @subscribe_callback.call(args)
  end

end
