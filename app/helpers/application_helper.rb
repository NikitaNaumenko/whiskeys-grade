# frozen_string_literal: true

module ApplicationHelper
  include AuthConcern

  def let(value)
    yield value
  end
end
