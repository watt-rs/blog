# _plugins/watt.rb
require 'rouge'

module Rouge
  module Lexers
    class Watt < RegexLexer
      title "Watt"
      desc "Custom language Watt"
      tag 'watt'

      filenames '*.watt'

      state :root do
        rule %r/#.*$/, Comment
        rule %r/(".*?")/, Str
        rule %r/\b(fn|let|if|else|match|elif|boil|panic|todo|type|as|enum)\b/, Keyword
        rule %r/[0-9]+/, Num
        rule %r/[\+\-\*\/=<>!]+/, Operator
        rule %r/[a-zA-Z_][a-zA-Z0-9_]*/, Name
        rule %r/\s+/, Text
      end
    end
  end
end
