class CurricularComponentsController < ApplicationController
  before_action :set_curricular_component, only: %i[ show edit update destroy ]

  # GET /curricular_components or /curricular_components.json
  def index
    @curricular_components = CurricularComponent.all
    @curricular_component = CurricularComponent.new
  end

  # GET /curricular_components/1 or /curricular_components/1.json
  def show
  end

  # GET /curricular_components/new
  def new
    @curricular_component = CurricularComponent.new
  end

  # GET /curricular_components/1/edit
  def edit
  end

  # POST /curricular_components or /curricular_components.json
  def create
    @curricular_component = CurricularComponent.new(curricular_component_params)
    respond_to do |format|
      if @curricular_component.save
        format.html { redirect_to curricular_components_path, notice: "Curricular component was successfully created." }
        format.json { render :show, status: :created, location: @curricular_component }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @curricular_component.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /curricular_components/1 or /curricular_components/1.json
  def update
    respond_to do |format|
      if @curricular_component.update(curricular_component_params)
        format.html { redirect_to curricular_components_path, notice: "Curricular component was successfully updated." }
        format.json { render :show, status: :ok, location: @curricular_component }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @curricular_component.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /curricular_components/1 or /curricular_components/1.json
  def destroy
    @curricular_component.destroy

    respond_to do |format|
      format.html { redirect_to curricular_components_path, status: :see_other, notice: "Curricular component was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_curricular_component
      @curricular_component = CurricularComponent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def curricular_component_params
      params.require(:curricular_component).permit(:nome, :serie, :area, :aulas, :responsible_id, :second_professor_name, curso: [])
    end


end
