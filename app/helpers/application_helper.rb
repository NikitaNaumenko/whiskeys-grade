# frozen_string_literal: true

module ApplicationHelper
  include AuthConcern

  def let(value)
    yield value
  end

  def default_search_form_options(options = {})
    { method: 'get',
      wrapper: :inline_form,
      html: { class: 'row row-cols-lg-auto g-3 align-items-center' },
      defaults: { label: false, required: false } }.merge(options)
  end
end
