class MarkBoardJob < ApplicationJob
  queue_as :default

  def perform(board)
    ActionCable.server.broadcast "board_channel", { board: board, template: draw(board, board.id) }
  end

  def draw(board, id)
    ApplicationController.render(partial: 'boards/display_board', locals: { board: board, params: id, game: board.game })
  end
end
