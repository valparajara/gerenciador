class RenameColumnAnswerAlternative < ActiveRecord::Migration
  def change
    rename_column :alternatives, :anwser, :answer
  end
end
