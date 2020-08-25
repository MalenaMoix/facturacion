class CreateFacturations < ActiveRecord::Migration[5.2]
  def change
    create_table :facturations, id: :integer  do |t|
      t.text :comentario
      t.integer :otro_gasto
      t.date :fecha
      t.boolean :bloqueado
      t.date :last_modification_date_bloqueado
      t.text :user_name_last_mod


      t.references :projects, type: :integer, foreign_key: true
    end
  end
end
