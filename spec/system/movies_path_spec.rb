require 'rails_helper'

describe 'movies_path' do
  it 'should have the header text => "Catálogo de Filmes' do
    # arrange
    # act
    visit root_path
    click_on 'Ver Catálogo'

    # assert
    expect(current_path).to eq(movies_path)
    expect(page).to have_content('Catálogo de Filmes')
  end

  it 'should have a header link with text => "Adicionar filme"' do
    # arrange
    # act
    visit movies_path

    # assert
    expect(page).to have_link('Adicionar filme')
  end

  it 'when there is no movies => "Nenhum filme cadastrado' do
    # arrange
    # act
    visit movies_path

    # assert
    expect(page).to have_content('Nenhum filme cadastrado.')
  end

  it 'when there is no movies => "Seja o primeiro a cadastrar um filme no sistema.' do
    # arrange
    # act
    visit movies_path

    # assert
    expect(page).to have_content('Seja o primeiro a cadastrar um filme no sistema.')
  end

  it 'when there is no movies should have a link to => "Adicionar um novo filme"' do
    # arrange
    # act
    visit movies_path

    # assert
    expect(page).to have_link('Adicionar um novo filme')
  end

  it 'when no movies, click on link => "Adicionar um novo filme", redirect to => "/movies/new"' do
    # arrange
    # act
    visit movies_path
    click_on 'Adicionar um novo filme'

    # assert
    expect(current_path).to eq(new_movie_path)
    expect(page).to have_content("Cadastrar novo Filme")
  end
end