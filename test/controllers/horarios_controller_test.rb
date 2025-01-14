require "test_helper"

class HorariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @horario = horarios(:one)
  end

  test "should get index" do
    get horarios_url
    assert_response :success
  end

  test "should get new" do
    get new_horario_url
    assert_response :success
  end

  test "should create horario" do
    assert_difference('Horario.count') do
      post horarios_url, params: { horario: { aulas: @horario.aulas, d1: @horario.d1, d2: @horario.d2, d3: @horario.d3, d4: @horario.d4, d5: @horario.d5, nome: @horario.nome } }
    end

    assert_redirected_to horario_url(Horario.last)
  end

  test "should show horario" do
    get horario_url(@horario)
    assert_response :success
  end

  test "should get edit" do
    get edit_horario_url(@horario)
    assert_response :success
  end

  test "should update horario" do
    patch horario_url(@horario), params: { horario: { aulas: @horario.aulas, d1: @horario.d1, d2: @horario.d2, d3: @horario.d3, d4: @horario.d4, d5: @horario.d5, nome: @horario.nome } }
    assert_redirected_to horario_url(@horario)
  end

  test "should destroy horario" do
    assert_difference('Horario.count', -1) do
      delete horario_url(@horario)
    end

    assert_redirected_to horarios_url
  end
end
