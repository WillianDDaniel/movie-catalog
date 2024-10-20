require 'rails_helper'

describe 'new_movie_path' do
  it 'should have title text => "Cadastrar novo Filme' do
    # arrange
    # act
    visit new_movie_path

    # assert
    expect(current_path).to eq(new_movie_path)
    expect(page).to have_content('Cadastrar novo Filme')
  end

  context 'when there is no genre and no director' do
    it 'should have text "Nenhum gênero ou diretor encontrado.' do
      # arrange
      # act
      visit new_movie_path

      # assert
      expect(page).to have_content('Nenhum gênero ou diretor encontrado.')
    end

    it 'should have text "Para cadastrar um filme, primeiro cadastre pelo menos um gênero e um diretor."' do
      # arrange
      # act
      visit new_movie_path

      # assert
      expect(page).to have_content('Para cadastrar um filme, primeiro cadastre pelo menos um gênero e um diretor.')
    end

    it 'should have a link with text => "Cadastrar gênero"' do
      # arrange
      # act
      visit new_movie_path

      # assert
      expect(page).to have_link('Cadastrar gênero')
    end

    it 'should have a link with text => "Cadastrar diretor"' do
      # arrange
      # act
      visit new_movie_path

      # assert
      expect(page).to have_link('Cadastrar diretor')
    end
  end

  context 'when there is no director' do
    it 'should have text "Nenhum diretor encontrado.' do
      # arrange
      Genre.create!(name: 'Ação')

      # act
      visit new_movie_path

      # assert
      expect(page).to have_content('Nenhum diretor encontrado.')
    end

    it 'should have a link with text => "Cadastrar diretor"' do
      # arrange
      Genre.create!(name: 'Ação')

      # act
      visit new_movie_path

      # assert
      expect(page).to have_link('Cadastrar diretor')
    end
  end

  context 'when have director and genre' do
    it 'should have a form' do
      # arrange
      Genre.create!(name: 'Ação')

      Director.create!(
        name: 'George Lucas', nacionality: 'Estados Unidos',
        birthdate: '1944-03-01', favorite_genre_id: 1
      )

      # act
      visit new_movie_path

      # assert
      expect(page).to have_selector('form')

      expect(page).to have_field('Nome do Filme')
      expect(page).to have_field('Ano de Lançamento')
      expect(page).to have_field('País')
      expect(page).to have_field('Gênero')
      expect(page).to have_field('Sinopse')
      expect(page).to have_field('Duração')
      expect(page).to have_field('Diretor')
      expect(page).to have_field('URL da Capa')
      expect(page).to have_field('Salvar como Rascunho')

      expect(page).to have_button('Cadastrar')
    end
  end
end
