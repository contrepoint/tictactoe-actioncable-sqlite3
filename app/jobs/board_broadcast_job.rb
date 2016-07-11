class BoardBroadcastJob < ApplicationJob
  queue_as :default

   def perform(updated_board)
     byebug
     ActionCable.server.broadcast 'boards', {board: render_message(updated_board)}
   end

   private
   def render_message(updated_board)
     byebug
     ApplicationController.renderer.render(partial: 'boards/display_board', locals: { board: updated_board})
     byebug
   end
 end
