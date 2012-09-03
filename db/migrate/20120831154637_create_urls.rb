class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :long, :nil => false
      t.string :short, :nil => false

      t.timestamps
    end

    add_index :urls, :long
    add_index :urls, :short
  end
end