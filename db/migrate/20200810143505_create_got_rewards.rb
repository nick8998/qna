class CreateGotRewards < ActiveRecord::Migration[6.0]
  def change
    create_table :got_rewards do |t|
      t.references :user, foreign_key: true
      t.references :reward, foreign_key: true
      t.timestamps
    end
  end
end
