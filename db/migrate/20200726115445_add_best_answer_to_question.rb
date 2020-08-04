class AddBestAnswerToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :answers, :best, :boolean, default: false
  end
end
