class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :sex
      t.string :mail
      t.date :birthday
      t.string :job
      t.string :password_digest
      t.timestamps null:false
    end
  end
end
