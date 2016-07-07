class Game < ApplicationRecord
  has_one :board
  belongs_to :challenger, class_name: 'User', optional: true
  belongs_to :challenged, class_name: 'User',  optional: true
  belongs_to :winner, class_name: 'User', optional: true
  belongs_to :active_player, class_name: 'User', optional: true

  after_create :set_board_id, :create_board, on: :create

  def select_who_starts
    @starting_player = [self.challenger, self.challenged].sample
    self.active_player = @starting_player
    self.save
    return @starting_player
  end


  def switch_turns
    if self.active_player == self.challenger
      self.active_player = self.challenged
      self.save
    else
      self.active_player = self.challenger
      self.save
    end
  end

  def ended?
    board = self.board
    if board.won?
    self.who_won?
      return true
    elsif board.tie?
      return true
    else
      return false
    end
  end

  def who_won?
    case self.winning_marker
    when self.challenger_user_marker
      self.winner = self.challenger
    when self.challenged_user_marker
      self.winner = self.challenged
    else
      # should probably raise an error since it shouldn't hit this part...?
    end
    self.save
  end

  private
    def set_board_id
      self.board_id = self.id
      self.save
    end

    def create_board
      new_board = Board.create!
      # should this raise an error if the board doesn't save for whatever reason?
    end

end
