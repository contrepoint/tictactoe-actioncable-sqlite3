class BoardsController < ApplicationController
  before_action :is_game_ongoing?, :is_active_player?, only: [:update]

  def show
    @game = Game.find(params[:id])
    @board = @game.board
  end

  def update
    @game = Game.find(params[:id])
    @board = @game.board
    # ActionCable.server.broadcast
    position = params[:position].to_i
    @board.state[position] = "x"
    @board.save
    # @board_state = @board.state.split('')
    MarkBoardJob.perform_now(@board)
    # byebug
    redirect_to @board
    # @game = Game.find(params[:id])
    # position = params[:position].to_i
    # find_marker
    #
    # if @game.board.empty_cell?(position)
    #   @game.board.mark_the_spot(position, @marker)
    #   # @game.switch_turns
    #   flash[:notice] = "You successfully placed your marker at position #{position}!"
    # else
    #   flash[:notice] = "Position #{position} is already taken!"
    # end
    #
    # updated_board = @game.board.state.split('')
    # BoardBroadcastJob.perform_later(updated_board)

    # if @game.ended?
    #   flash[:alert] = "Game is over!"
    # else
    #   flash[:alert] = "Game's not over!"
    # end
    redirect_to board_path(params[:id])
  end

  private
    def is_game_ongoing?
      game = Game.find(params[:id])
      if game.status != 'game in progress'
        redirect_to board_path(params[:id])
        flash[:notice] = "The game is not in progress! You cannot mark any spots on the board"
      end
    end

    def is_active_player?
      game = Game.find(params[:id])
      if current_user != game.challenger && current_user != game.challenged
        redirect_to root_path
        flash[:notice] = "You aren't in this game!"
      elsif current_user != game.active_player
        redirect_to board_path
        flash[:notice] = "It isn't your turn! Please wait for the other player to make their move."
      end
    end

    def find_marker
      if current_user == @game.challenger
        @marker = @game.challenger_user_marker
        return @marker
      elsif current_user == @game.challenged
        @marker = @game.challenged_user_marker
        return @marker
      else
        # shouldn't get here due to validation methods earlier but should I raise an error just in case?
      end
    end
end
