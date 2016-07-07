App.board = App.cable.subscriptions.create "BoardChannel",
  connected: ->
    # alert("whee you are connected!")# Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    debugger
    console.log(data)
    alert("whee")

  # mark_a_cell: ->
  #   @perform 'mark_a_cell'
