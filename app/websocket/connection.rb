module Websocket
  class Connection < LiteCable::Connection::Base

    identified_by :user

    def connect
      @user = 'Poilon'
      # reject_unauthorized_connection unless @user
      $stdout.puts "#{@user} connected"
    end

    def disconnect
      $stdout.puts "#{@user} disconnected"
    end

  end
end
