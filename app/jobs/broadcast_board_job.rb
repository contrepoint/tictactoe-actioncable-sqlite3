class BroadcastBoardJob < ApplicationJob
  queue_as :default

  def perform(updated_board)
    ActionCable.server.broadcast 'board_channel' # , board: render_message(updated_board)
  end

  private
  def render_message(updated_board)
    # byebug
    # RAILS5_THING: Controller can render partial without being in scope of the controller.
    ApplicationController.renderer
      .render(partial: 'boards/display_board', locals: { board: updated_board })
  end
end
