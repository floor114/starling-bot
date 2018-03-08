class CreateLunches < ActiveRecord::Migration[5.1]
  def change
    create_table :lunches do |t|
      t.integer :chat_id
      t.text :members
    end
  end
end
