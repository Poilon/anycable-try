module Websocket
  class Channel < LiteCable::Channel::Base

    identifier :channel

    def subscribed
      puts 'subscribed'
      reject unless user
      stream_from 'poilon'
    end

    def execute(data)
      result = NoMeetingsApiSchema.execute(
        data['query'], context: { current_user: user }
      )
      LiteCable.broadcast('poilon', result: result)
    end

  end
end
