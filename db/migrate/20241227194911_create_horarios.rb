class CreateHorarios < ActiveRecord::Migration[6.1]
  def change
    create_table :horarios do |t|
      t.string :nome
      t.integer :aulas
      t.text :d1, default: '[]'
      t.text :d2, default: '[]'
      t.text :d3, default: '[]'
      t.text :d4, default: '[]'
      t.text :d5, default: '[]'

      t.timestamps
    end
  end
end
