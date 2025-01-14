class ChangeCursoInCurricularComponents < ActiveRecord::Migration[6.1]
  def change
    change_column :curricular_components, :curso, :text, array: true, default: '[]'

  end
end
