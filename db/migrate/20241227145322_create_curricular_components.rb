class CreateCurricularComponents < ActiveRecord::Migration[6.1]
  def change
    create_table :curricular_components do |t|
      t.string :nome
      t.string :serie
      t.string :area
      t.string :curso
      t.integer :aulas
      t.references :responsible, null: false, foreign_key: { to_table: :teachers }

      t.timestamps
    end
  end
end
