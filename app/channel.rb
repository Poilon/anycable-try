module App
  class Channel < LiteCable::Channel::Base

    identifier :channel

    def subscribed
      puts 'subscribed'
      reject unless user
      stream_from 'poilon'
    end

    def speak(data)
      puts data['message']
      LiteCable.broadcast('poilon', user: user, message: data['message'])
    end

  end
end
