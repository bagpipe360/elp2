WebsocketRails::EventMap.describe do
  # You can use this file to map incoming events to controller actions.
  # One event can be mapped to any number of controller actions. The
  # actions will be executed in the order they were subscribed.
  #
  # Uncomment and edit the next line to handle the client connected event:
  # subscribe :client_connected, :to => WebSocketsController, :with_method => :user_joined_lesson
  #
  # Here is an example of mapping namespaced events:
#  namespace :user do
#    subscribe :joined, :to => SocketsController, :with_method => :user_joined_lesson
#  end

  # The above will handle an event triggered on the client like `product.new`.
end
