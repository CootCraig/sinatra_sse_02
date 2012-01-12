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
    @state = nil
  end
  # talk,idle,hold.
  # idle => talk
  # talk => idle | hold
  # hold => talk
  def start
    while true do
      sleep ((Random.rand(8)) + 4)
      next_state()
      data = {source: 'actor', time: Time.now.to_s, state: @state.to_s}
      puts "ActorSource reporting: #{data.to_s}"
      @target.report!(data)
    end
  end
  def next_state
    @state = case @state
             when :idle
               :talk
             when :talk
               if Random.rand(1000) < 200
                 :hold
               else
                 :idle
               end
             when :hold
               :talk
             else
               :idle
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

