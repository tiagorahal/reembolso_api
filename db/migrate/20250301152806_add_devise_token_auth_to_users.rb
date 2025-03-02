class AddDeviseTokenAuthToUsers < ActiveRecord::Migration[8.0]
  def change
    change_table(:users) do |t|
      ## Required
      t.string :provider, null: false, default: "email"
      t.string :uid, null: false, default: ""

      ## Tokens
      t.json :tokens

      ## Indexes
      t.index [ :uid, :provider ], unique: true
    end
  end
end
