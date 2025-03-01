class CreateReembolsos < ActiveRecord::Migration[8.0]
  def change
    create_table :reembolsos do |t|
      t.references :user, null: false, foreign_key: true
      t.text :descricao
      t.decimal :valor
      t.date :data

      t.timestamps
    end
  end
end
