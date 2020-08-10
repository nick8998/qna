class CreateRewards < ActiveRecord::Migration[6.0]
  def change
    create_table :rewards do |t|
      t.string :title
      t.string :picture
      t.belongs_to :question, foreign_key: true

      t.timestamps
    end
  end
end
