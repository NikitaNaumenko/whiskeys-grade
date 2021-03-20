# frozen_string_literal: true

module ParsedBodyHelper
  def parsed_body
    JSON.parse(response.body)
  end
end
