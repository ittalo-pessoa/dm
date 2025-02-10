class AddPontuacaoToTeachers < ActiveRecord::Migration[6.1]
  def change
    add_column :teachers, :pontuacao, :integer
  end
end
