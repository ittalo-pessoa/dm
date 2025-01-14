require "application_system_test_case"

class CurricularComponentsTest < ApplicationSystemTestCase
  setup do
    @curricular_component = curricular_components(:one)
  end

  test "visiting the index" do
    visit curricular_components_url
    assert_selector "h1", text: "Curricular Components"
  end

  test "creating a Curricular component" do
    visit curricular_components_url
    click_on "New Curricular Component"

    fill_in "Area", with: @curricular_component.area
    fill_in "Aulas", with: @curricular_component.aulas
    fill_in "Curso", with: @curricular_component.curso
    fill_in "Nome", with: @curricular_component.nome
    fill_in "Responsible", with: @curricular_component.responsible
    fill_in "Serie", with: @curricular_component.serie
    click_on "Create Curricular component"

    assert_text "Curricular component was successfully created"
    click_on "Back"
  end

  test "updating a Curricular component" do
    visit curricular_components_url
    click_on "Edit", match: :first

    fill_in "Area", with: @curricular_component.area
    fill_in "Aulas", with: @curricular_component.aulas
    fill_in "Curso", with: @curricular_component.curso
    fill_in "Nome", with: @curricular_component.nome
    fill_in "Responsible", with: @curricular_component.responsible
    fill_in "Serie", with: @curricular_component.serie
    click_on "Update Curricular component"

    assert_text "Curricular component was successfully updated"
    click_on "Back"
  end

  test "destroying a Curricular component" do
    visit curricular_components_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Curricular component was successfully destroyed"
  end
end
