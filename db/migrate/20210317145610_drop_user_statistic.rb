class DropUserStatistic < ActiveRecord::Migration[5.2]
  def change
    drop_table :user_statistics
  end
end
