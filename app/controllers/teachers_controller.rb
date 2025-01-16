class TeachersController < ApplicationController
  before_action :set_teacher, only: %i[ show edit update destroy ]

  def horarios_do_professor
    # Encontrar o professor com base no ID
    professor = Teacher.find_by(id: params[:id])

    if professor.nil?
      redirect_to teachers_path, alert: 'Professor não encontrado.'
      return
    end

    # Inicializar a estrutura de horários
    @horarios_professor = {
      professor: professor.nick_name,
      horarios: {}
    }

    # Iterar pelos dias da semana e buscar os horários atribuídos ao professor
    (1..5).each do |dia|
      dia_key = "d#{dia}"
      Horario.all.each do |horario|
        aulas = JSON.parse(horario[dia_key] || '[]') rescue []
        aulas.each_with_index do |aula, index|
          if aula.include?(professor.nick_name)
            @horarios_professor[:horarios][dia_key] ||= []
            @horarios_professor[:horarios][dia_key][index] = {
              horario: horario.nome,
              componente: aula.split(' - ').last
            }
          end
        end
      end
    end

    # Renderiza a view com os dados
    render :horarios_do_professor
  end

  # GET /teachers or /teachers.json
  def index
    @teachers = Teacher.all
    @teacher = Teacher.new
  end

  # GET /teachers/1 or /teachers/1.json
  def show

  end

  # GET /teachers/new
  def new
    @teachers = Teacher.all

  end

  # GET /teachers/1/edit
  def edit
  end

  # POST /teachers or /teachers.json
  def create
    @teacher = Teacher.new(teacher_params)

    respond_to do |format|
      if @teacher.save
        format.html { redirect_to teachers_path, notice: "Teacher was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teachers/1 or /teachers/1.json
  def update
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.html { redirect_to teachers_path, notice: "Professor(a) atualizado com sucesso!" }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teachers/1 or /teachers/1.json
  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy

    respond_to do |format|
      format.html { redirect_to teachers_path, status: :see_other, notice: "Professor(a) deletado com suecesso!" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def teacher_params
      params.require(:teacher).permit(:name, :nick_name)
    end
end
