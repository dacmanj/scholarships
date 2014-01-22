module ActionView::Helpers::TranslationHelper    
  def t_with_logging(key, options={})
    Rails.logger.info "TEST" "#{key}"
    t_without_logging(key, options)
  end
  alias_method_chain :t, :logging
end