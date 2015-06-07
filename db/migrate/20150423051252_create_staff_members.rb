class CreateStaffMembers < ActiveRecord::Migration
  def change
    create_table :staff_members do |t|
      t.string :email, null: false #email address
      t.string :email_for_index, null: false #email address for search(?)
      t.string :family_name, null: false #family name
      t.string :given_name, null: false #given name
      t.string :family_name_kana, null: false #family name kana
      t.string :given_name_kana, null: false #given name kana
      t.string :hashed_password  #Password
      t.date :start_date, null: false #start date
      t.date :end_date    #end date
      t.boolean :suspended, null: false, default: false #suspention flag

      t.timestamps
    end

    add_index :staff_members, :email_for_index, unique: true
    add_index :staff_members, [ :family_name_kana, :given_name_kana ]
  end
end
