class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.references :conversation, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      # DIVE19_1_メッセージ機能 で編集 
      # nil が入らないように default: false を追加
      t.boolean :read, default: false

      t.timestamps null: false
    end
  end
end
