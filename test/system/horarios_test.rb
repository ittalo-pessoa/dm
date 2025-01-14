require "application_system_test_case"

class HorariosTest < ApplicationSystemTestCase
  setup do
    @horario = horarios(:one)
  end

  test "visiting the index" do
    visit horarios_url
    assert_selector "h1", text: "Horarios"
  end

  test "creating a Horario" do
    visit horarios_url
    click_on "New Horario"

    fill_in "Aulas", with: @horario.aulas
    fill_in "D1", with: @horario.d1
    fill_in "D2", with: @horario.d2
    fill_in "D3", with: @horario.d3
    fill_in "D4", with: @horario.d4
    fill_in "D5", with: @horario.d5
    fill_in "Nome", with: @horario.nome
    click_on "Create Horario"

    assert_text "Horario was successfully created"
    click_on "Back"
  end

  test "updating a Horario" do
    visit horarios_url
    click_on "Edit", match: :first

    fill_in "Aulas", with: @horario.aulas
    fill_in "D1", with: @horario.d1
    fill_in "D2", with: @horario.d2
    fill_in "D3", with: @horario.d3
    fill_in "D4", with: @horario.d4
    fill_in "D5", with: @horario.d5
    fill_in "Nome", with: @horario.nome
    click_on "Update Horario"

    assert_text "Horario was successfully updated"
    click_on "Back"
  end

  test "destroying a Horario" do
    visit horarios_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Horario was successfully destroyed"
  end
end
