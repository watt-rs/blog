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
        rule %r(//.*$), Comment::Single
        rule %r(/[*].*?[*]/), Comment::Multiline, :mcomment
        rule %r/(".*?")/, Str
        rule %r/\b(fn|let|if|else|elif|match|boil|panic|todo|type|as|enum)\b/, Keyword
        rule %r/\b(int|string|bool|float)\b/, Keyword::Type
        rule %r/[0-9]+(\.[0-9]+)?/, Num
        rule %r/(==|!=|&&|\|\||\+=|-=|\*=|\/=|<>|[+\-*\/=%!<>&|])/, Operator
        rule %r/[:.,;()\[\]{}]/, Text
        rule %r/[a-zA-Z_][a-zA-Z0-9_]*/, Name
        rule %r/\s+/, Text
      end

      state :mcomment do
        rule %r/[^*]+/, Comment::Multiline
        rule %r/\*\/$/, Comment::Multiline, :pop!
        rule %r/[*]/, Comment::Multiline
      end
    end
  end
end

