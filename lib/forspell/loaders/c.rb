# frozen_string_literal: true

require_relative 'ruby'

module Forspell::Loaders
  class C < Ruby
    def initialize(file: nil)
      super
      @parser_class = YARD::Parser::C::CParser
    end

    def load_comments
      @input = @input.encode('UTF-8', invalid: :replace, replace: '?') unless @input.valid_encoding?

      @comments = @parser_class.new(@input, @file).parse
                               .grep(YARD::Parser::C::Comment)
                               .map { |comment| [:comment, comment.source, [comment.line]] }
    end
  end
end