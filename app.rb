class App
  def self.start
    Celluloid::Actor[:reporter] = ActorReporter.new
    Celluloid::Actor[:source] = ActorSource.new(Celluloid::Actor[:reporter])
    Celluloid::Actor[:source].start!
    puts "App.start"
  end
end
class ActorSource
  include Celluloid
  def initialize(target)
    @target = target
  end
  def start
    while true do
      sleep ((Random.rand(8)) + 4)
      data = {source: 'actor', time: Time.now.to_s}
      puts "ActorSource reporting: #{data.to_s}"
      @target.report!(data)
    end
  end
end
class ActorReporter
  include Celluloid
  def initialize
    @streams = {}
  end
  def register_and_wait(id,stream)
    puts "register #{id} #{stream.to_s}"
    @streams[stream] = id
    wait :forever
  end
  def report(data)
    puts "report #{data.to_s}"
    @streams.each do |stream,id|
      data[:id] = id
      msg = "data: #{JSON(data)}\n\n"
      stream << msg
    end
  end
end

