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
        # ---------------- comments ----------------
        rule %r(//.*$), Comment::Single
        rule %r(/[*]), Comment::Multiline, :mcomment

        # ---------------- strings -----------------
        rule %r/(".*?")/, Str

        # ---------------- keywords ----------------
        rule %r/\b(
          fn|let|if|else|elif|match|boil|panic|todo|
          type|as|enum|use|const|extern|
          for|loop|in
        )\b/x, Keyword

        # ---------------- numbers -----------------
        rule %r/[0-9]+(\.[0-9]+)?/, Num

        # ---------------- operators ---------------
        rule %r/(==|!=|&&|\|\||\+=|-=|\*=|\/=|<>|[+\-*\/=%!<>&|])/, Operator

        # ---------------- type annotation entry ---
        rule %r/:/, Text, :type

        # ---------------- punctuation -------------
        rule %r/[.,;()\[\]{}]/, Punctuation

        # ---------------- identifiers -------------
        rule %r/[a-zA-Z_][a-zA-Z0-9_]*/, Name

        # ---------------- whitespace --------------
        rule %r/\s+/, Text
      end

      # ===== TYPE STATE =====
      state :type do
        rule %r/\s+/, Text

        # built-in primitive types
        rule %r/\b(int|string|bool|float)\b/, Keyword::Type

        # generic brackets, arrays, tuples
        rule %r/[<>\[\],]/, Punctuation

        # User-defined types (PascalCase)
        rule %r/[A-Z][a-zA-Z0-9_]*/, Name::Class

        # other type identifiers
        rule %r/[a-zA-Z_][a-zA-Z0-9_]*/, Keyword::Type

        # exit type annotation
        rule %r/(?==|;|\)|\{|,)/, Text, :pop!
      end

      # ===== MULTILINE COMMENT =====
      state :mcomment do
        rule %r([^*]+), Comment::Multiline
        rule %r(\*/), Comment::Multiline, :pop!
        rule %r(\*), Comment::Multiline
      end
    end
  end
end

