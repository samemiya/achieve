class CreateContacts < ActiveRecord::Migration
  def change

    # create_table :blogs do |t|
    #   t.string :title
    #   t.text :content

    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.text :content

      t.timestamps null: false
    end
  end
end
