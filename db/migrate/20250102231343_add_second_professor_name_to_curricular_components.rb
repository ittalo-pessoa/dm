class AddSecondProfessorNameToCurricularComponents < ActiveRecord::Migration[6.1]
  def change
    add_column :curricular_components, :second_professor_name, :string
  end
end
