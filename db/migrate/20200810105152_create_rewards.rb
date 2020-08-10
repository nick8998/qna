class CreateRewards < ActiveRecord::Migration[6.0]
  def change
    create_table :rewards do |t|
      t.string :title
      t.string :picture

      t.timestamps
    end
  end
end
