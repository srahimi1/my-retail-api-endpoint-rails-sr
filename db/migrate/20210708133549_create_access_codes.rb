class CreateAccessCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :access_codes do |t|
      t.string :access_code
      t.integer :valid
      t.timestamps
    end
  end
end
