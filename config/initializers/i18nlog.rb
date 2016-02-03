module ActionView::Helpers::TranslationHelper
  def t_with_logging(key, options={})
    if Rails.env.development?
      Rails.logger.info "Translating: " "#{key}"
    end
    t_without_logging(key, options)
  end
  alias_method_chain :t, :logging
end
