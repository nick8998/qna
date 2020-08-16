class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.integer :votes_up, default: 0
      t.integer :votes_down, default: 0
      t.belongs_to :votable, polymorphic: true

      t.timestamps
    end
  end
end
