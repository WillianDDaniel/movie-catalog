require 'rails_helper'

describe 'Homepage' do

  it 'and see the title => "FilmClub"' do
    # arrange
    # act
    visit root_path

    # assert
    expect(page).to have_title('FilmClub')
  end

  it 'and see the welcome text => "Bem vindos ao FilmClub"' do
    # arrange
    # act
    visit root_path

    # assert
    expect(page).to have_content('Bem vindos ao FilmClub!')
  end

  it 'and see the subtitle => "Seu catálogo de filmes na web"' do
    # arrange
    # act
    visit root_path

    # assert
    expect(page).to have_content('Seu catálogo de filmes na web')
  end

  it 'and see "Ver Catálogo' do
    # arrange
    # act
    visit root_path

    # assert
    expect(page).to have_content('Ver Catálogo')
  end

  it 'and see "Adicionar filme"' do
    # arrange
    # act
    visit root_path

    # assert
    expect(page).to have_content('Adicionar Filme')
  end

  it 'and click on "Ver Catálogo" => redirect to "/movies' do
    # arrange
    # act
    visit root_path
    click_on 'Ver Catálogo'

    # assert
    expect(current_path).to eq(movies_path)
  end

  it 'and click on "Adicionar Filme" => redirect to "/movies/new' do
    # arrange
    # act
    visit root_path
    click_on 'Adicionar Filme'

    # assert
    expect(current_path).to eq(new_movie_path)
  end
end