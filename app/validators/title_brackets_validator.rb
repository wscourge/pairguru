# frozen_string_literal: true

class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    return if valid?(record.title)

    record.errors.add(:base, "Title brackets are not closed properly")
  end

  private

  PAIRS = { "(" => ")", "[" => "]", "{" => "}" }.freeze

  def valid?(title)
    return false if empty_brackets?(title)

    brackets = []
    title.each_char do |char|
      brackets << char if PAIRS.key?(char)
      return false if PAIRS.key(char) && PAIRS.key(char) != brackets.pop
    end
    brackets.empty?
  end

  def empty_brackets?(title)
    title.include?("()") || title.include?("[]") || title.include?("{}")
  end
end
