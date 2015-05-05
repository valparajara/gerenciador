class Alternatives < ActiveRecord::Migration
  def change
    create_table :alternatives do |a|
      a.string :alternative, limit: 1
      a.text :anwser
      a.integer :question_id
      a.timestamps
    end
  end
end
