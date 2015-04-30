class Question < ActiveRecord::Migration
  def change
    create_table :questions do |q|
      q.string :code, limit: 10
      q.text :enunciation
      q.string :template , limit: 1
      q.timestamps
    end
  end
end
