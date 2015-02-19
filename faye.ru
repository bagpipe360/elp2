require 'faye'
bayeux = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)

Faye::WebSocket.load_adapter('thin')


run bayeux