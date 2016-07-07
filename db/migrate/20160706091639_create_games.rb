class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.references :board, references: :boards
      t.string :status

      t.references :challenger, references: :users
      t.references :challenged, references: :users
      t.string :challenger_user_marker
      t.string :challenged_user_marker

      t.references :active_player, references: :users

      t.references :winner, references: :users
      t.string :winning_marker

      t.timestamps
    end
  end
end
