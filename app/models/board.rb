class Board < ApplicationRecord
  belongs_to :game, optional: true
  after_create :set_game_id, on: :create
  # after_create_commit { MessageBroadcastJob.perform_later self }
  after_update_commit :broadcast_self

  def broadcast_self
    @updated_board = self.state.split('')
    BoardBroadcastJob.perform_later(@updated_board)
    # can refactor the split out later
    byebug
  end

# Mark a spot
	def empty_cell?(position)
		if self.state[position] == "-"
			return true
		else
			return false
		end
	end

  def mark_the_spot(position, marker)
		self.state[position] = marker
    self.save
	end

# Won?
  def won?
    if check_lines == 'x'
      self.game.winning_marker = 'x'
      self.game.status = 'game won'
      self.active_player = nil
      self.save
      return true
    elsif check_lines == 'o'
      self.game.winning_marker = 'o'
      self.game.status = 'game won'
      self.active_player = nil
      self.save
      return true
    else
      return false
    end
  end

  def lines
    w = self.state.split('')
    @lines = [ w[0..2], w[3..5], w[6..8],
  		[w[0], w[3], w[6]], [w[1], w[4], w[7]], [w[2], w[5], w[8]],
  		[w[0], w[4], w[8]], [w[2], w[4], w[6]]]
  end

  def check_lines
    lines.each do |x|
      if x.uniq.size == 1 && x.uniq != ['-']
        return x[0]
      end
    end
  end

# Tie?
  def tie?
    if full? == true && won? == false
      self.game.winning_marker = 'none'
      self.game.status = 'game tied'
      self.game.active_player = nil
      self.save
      return true
    else
      return false # is this return part necessary? since full? will return true or false too
    end
  end

  def full?
    return !self.state.include?('-')
  end

  def set_game_id
    self.game_id = self.id
    self.save
  end
end
