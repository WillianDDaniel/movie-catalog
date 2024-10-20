module ApplicationHelper
  def format_errors(errors, model)

    errors_name = errors.map do |key, value|
      "#{key}"
    end

    errors_name.map do |name|

      I18n.t(".activerecord.attributes.#{model}.#{name}")

    end.uniq.to_sentence(last_word_connector: ' e ')

  end
end
