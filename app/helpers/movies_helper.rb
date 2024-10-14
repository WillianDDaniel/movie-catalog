module MoviesHelper
  def title_font_size_class(title)
    case title.length
    when 0..15
      'text-normal'
    else
      'text-small'
    end
  end

  def countries_for_select
    ISO3166::Country.translations('pt-br').map do |code, name|
      [name, name]
    end
  end

  def country_flag_class(name)
    code = ISO3166::Country.find_country_by_any_name(name).alpha2
    "flag-icon flag-icon-#{code.downcase}"
  end

end
