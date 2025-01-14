class AddCursoAndSerieToHorarios < ActiveRecord::Migration[6.1]
  def change
    add_column :horarios, :curso, :string
    add_column :horarios, :serie, :string
  end
end
