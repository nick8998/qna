class CreateVotesUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :votes_users do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :vote, foreign_key: true
      t.boolean :voted, default: false
      t.timestamps
    end
  end
end
