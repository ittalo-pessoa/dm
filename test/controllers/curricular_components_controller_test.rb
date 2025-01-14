require "test_helper"

class CurricularComponentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @curricular_component = curricular_components(:one)
  end

  test "should get index" do
    get curricular_components_url
    assert_response :success
  end

  test "should get new" do
    get new_curricular_component_url
    assert_response :success
  end

  test "should create curricular_component" do
    assert_difference('CurricularComponent.count') do
      post curricular_components_url, params: { curricular_component: { area: @curricular_component.area, aulas: @curricular_component.aulas, curso: @curricular_component.curso, nome: @curricular_component.nome, responsible: @curricular_component.responsible, serie: @curricular_component.serie } }
    end

    assert_redirected_to curricular_component_url(CurricularComponent.last)
  end

  test "should show curricular_component" do
    get curricular_component_url(@curricular_component)
    assert_response :success
  end

  test "should get edit" do
    get edit_curricular_component_url(@curricular_component)
    assert_response :success
  end

  test "should update curricular_component" do
    patch curricular_component_url(@curricular_component), params: { curricular_component: { area: @curricular_component.area, aulas: @curricular_component.aulas, curso: @curricular_component.curso, nome: @curricular_component.nome, responsible: @curricular_component.responsible, serie: @curricular_component.serie } }
    assert_redirected_to curricular_component_url(@curricular_component)
  end

  test "should destroy curricular_component" do
    assert_difference('CurricularComponent.count', -1) do
      delete curricular_component_url(@curricular_component)
    end

    assert_redirected_to curricular_components_url
  end
end
