class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.integer :value, default: 0
      t.belongs_to :votable, polymorphic: true

      t.timestamps
    end
  end
end
