class HorariosController < ApplicationController
  before_action :set_horario, only: %i[show edit update destroy]


  def show
    @horario = Horario.find(params[:id])
    @aulas = {
      d1: JSON.parse(@horario.d1),
      d2: JSON.parse(@horario.d2),
      d3: JSON.parse(@horario.d3),
      d4: JSON.parse(@horario.d4),
      d5: JSON.parse(@horario.d5)
    }
  end


  def montar_horarios
    if action_name == 'create'
      @componentes = CurricularComponent.all
    elsif action_name == 'edit'
      @componentes = []
      if @horario.curso == 'Agroecologia'
        CurricularComponent.all.each do |component|
          if (component.serie == '1º ANO') &&
             (component.curso == ['Agroecologia'] || component.curso.include?("Agroecologia")) &&
             @horario.serie == '1º ANO'
            @componentes.append(component)
          elsif (component.serie == '2º ANO') &&
                (component.curso == ['Agroecologia'] || component.curso.include?("Agroecologia")) &&
                @horario.serie == '2º ANO'
            @componentes.append(component)
          elsif (component.serie == '3º ANO') &&
                (component.curso == ['Agroecologia'] || component.curso.include?("Agroecologia")) &&
                @horario.serie == '3º ANO'
            @componentes.append(component)
          end
        end
      elsif @horario.curso == 'Análises Clínicas'
        CurricularComponent.all.each do |component|
          if (component.serie == '1º ANO') &&
             (component.curso == ['Análises Clínicas'] || component.curso.include?("Análises Clínicas")) &&
             @horario.serie == '1º ANO'
            @componentes.append(component)
          elsif (component.serie == '2º ANO') &&
                (component.curso == ['Análises Clínicas'] || component.curso.include?("Análises Clínicas")) &&
                @horario.serie == '2º ANO'
            @componentes.append(component)
          elsif (component.serie == '3º ANO') &&
                (component.curso == ['Análises Clínicas'] || component.curso.include?("Análises Clínicas")) &&
                @horario.serie == '3º ANO'
            @componentes.append(component)
          end
        end
      elsif @horario.curso == 'Informática'
        CurricularComponent.all.each do |component|
          if (component.serie == '1º ANO') &&
             (component.curso == ['Informática'] || component.curso.include?("Informática")) &&
             @horario.serie == '1º ANO'
            @componentes.append(component)
          elsif (component.serie == '2º ANO') &&
                (component.curso == ['Informática'] || component.curso.include?("Informática")) &&
                @horario.serie == '2º ANO'
            @componentes.append(component)
          elsif (component.serie == '3º ANO') &&
                (component.curso == ['Informática'] || component.curso.include?("Informática")) &&
                @horario.serie == '3º ANO'
            @componentes.append(component)
          end
        end
      end
    end

    # Filtrar componentes que atingiram o limite de aulas para o horário atual
    @componentes = @componentes.reject do |componente|
      alocacoes_no_horario = (1..5).sum do |dia|
        dia_key = "d#{dia}"
        # Verificar alocações no horário específico
        JSON.parse(@horario[dia_key] || '[]').count { |aula| aula.include?(componente.nome) } rescue 0
      end

      alocacoes_no_horario >= (componente.aulas || 0)
    end

    @disponiveis = []
    @alocados_por_horario = {}

    #@professores_disponiveis
    @professores_disponiveis = {}
    @componentes.each do |componente|
      professor = componente.responsible
      @professores_disponiveis[professor.nick_name] ||= {
        available: {},
        alocados: {}
      }

      if componente.second_professor_name.present?
        segundo_professor = Teacher.find_by(nick_name: componente.second_professor_name)
        if segundo_professor
          @disponiveis << "#{professor.nick_name} e #{segundo_professor.nick_name} - #{componente.nome}"
          @professores_disponiveis[segundo_professor.nick_name] ||= {
            available: {},
            alocados: {}
          }
        end
      end

      unless @disponiveis.any? { |opcao| opcao.start_with?("#{professor.nick_name} e") }
        @disponiveis << "#{professor.nick_name} - #{componente.nome}"
      end
    end

    # Lógica existente para processar horários
    Horario.all.each do |horario|
      (1..5).each do |dia|
        dia_key = "d#{dia}"
        if horario[dia_key]
          alocados = JSON.parse(horario[dia_key]) rescue []
          alocados.each_with_index do |componente, index|
            next if componente.nil?
            if componente.include?(" - ")
              professores = componente.split(" - ").first.split(" e ")
            else
              professores = [componente]
            end

            horario_key = "#{dia_key}_#{index + 1}"
            @professores_disponiveis[professores.first] ||= { available: {}, alocados: {} }
            @professores_disponiveis[professores.first][:available][horario_key] = false
            @professores_disponiveis[professores.first][:alocados][horario_key] ||= []
            @professores_disponiveis[professores.first][:alocados][horario_key] << componente

            if professores.length > 1
              segundo_professor_nome = professores.last.strip
              segundo_professor = Teacher.find_by(nick_name: segundo_professor_nome)
              if segundo_professor
                @professores_disponiveis[segundo_professor.nick_name] ||= { available: {}, alocados: {} }
                @professores_disponiveis[segundo_professor.nick_name][:available][horario_key] = false
                @professores_disponiveis[segundo_professor.nick_name][:alocados][horario_key] ||= []
                @professores_disponiveis[segundo_professor.nick_name][:alocados][horario_key] << componente
              end
            end
          end
        end
      end
    end

    @disponiveis_json = @disponiveis.to_json
    @professores_disponiveis_json = @professores_disponiveis.to_json
    @alocacoes_por_componente = {}

    @componente_quantidade_aulas = CurricularComponent.all.each_with_object({}) do |componente, hash|
      hash[componente.nome] = componente.aulas
    end
    # Verifique no log ou use debug
    puts @componente_quantidade_aulas.inspect

  end





  def edit
    set_horario
    montar_horarios
    if params[:horario].present?
      (1..5).each do |dia|
        key = "d#{dia}".to_sym
        if params[:horario][key].present?
          @horario[key] = params[:horario][key].to_json
        end
      end
    else
      Rails.logger.error "Parâmetro :horario não foi enviado"
    end
  end


  # Ação para atualizar um horário existente
  def update
    @horario = Horario.find(params[:id])  # Encontra o horário com o ID passado como parâmetro
    if @horario.update(horario_params)    # Atualiza o horário com os parâmetros do formulário
      redirect_to @horario, notice: 'Horário atualizado com sucesso.'  # Redireciona para a página do horário atualizado
    else
      render :edit  # Caso ocorra erro, volta para o formulário de edição
    end
  end

  def new
    @horario = Horario.new
  end

  def create
    @horario = Horario.new(horario_params)
    montar_horarios
    # Converte os dados enviados em JSON para salvar como texto
    (1..5).each do |dia|
      key = "d#{dia}".to_sym
      @horario[key] = params[:horario][key].to_json if params[:horario][key].present?
    end

    if @horario.save
      redirect_to @horario, notice: "Horário criado com sucesso."
    else
      montar_horarios
      render :new
    end

  end

  def index
    @horarios = Horario.all
  end

  def destroy
    if @horario.destroy
      respond_to do |format|
        format.html { redirect_to horarios_url, notice: 'Horário foi excluído com sucesso.' }
        format.json { head :no_content } # Para suporte a AJAX
      end
    else
      respond_to do |format|
        format.html { redirect_to horarios_url, alert: 'Erro ao tentar excluir o horário.' }
        format.json { render json: @horario.errors, status: :unprocessable_entity }
      end
    end
  end

  def horarios_por_dia
    @horarios = Horario.all
    @horarios_nomes = @horarios.map(&:nome).uniq
    @horarios_por_dia = {}

    @horarios.each do |horario|
      (1..5).each do |dia|
        dia_key = "d#{dia}"
        @horarios_por_dia[dia_key] ||= {}
        if horario[dia_key].present?
          aulas = JSON.parse(horario[dia_key]) rescue []
          @horarios_por_dia[dia_key][horario.nome] ||= []
          @horarios_por_dia[dia_key][horario.nome].concat(aulas)
        end
      end
    end

    # Debug para verificar se os dados estão sendo processados corretamente
    puts @horarios_por_dia.inspect
    puts @horarios_nomes.inspect

    @horarios_nomes_json = @horarios_nomes.to_json
    @horarios_por_dia_json = @horarios_por_dia.to_json
  end





  private

  def set_horario
    @horario = Horario.find(params[:id])
  end

  def horario_params
    params.require(:horario).permit(:nome, :aulas, :curso, :serie,  d1: [], d2: [], d3: [], d4: [], d5: [])
  end
end
