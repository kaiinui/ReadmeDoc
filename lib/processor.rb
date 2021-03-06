class Processor
  # Returns @readme annotated statement from a file that specified by given filename.
  #
  # @param filename [String] The name of file
  # @return [String]
  def readme_document_from_file(filename)
    body = File.open(filename).read
    parse(body)
  end

  # @param body [String]
  # @return [String] Extracted Document
  def parse(body)
    statements = readme_annotated_statements(body)
    statements.map { |s|
      no_white = linefront_whitespace_eliminated_string(s)
      no_comment = linefront_comment_symbol_eliminated_string(no_white)
      linefront_whitespace_eliminated_string(no_comment)
    }.join("\n")
  end

  private

  # @param str String
  # @return Array
  def readme_annotated_statements(str)
    str.scan(/@readme([\s\S]*?)\/@readme/m).flatten
  end

  # @param str String
  # @return String
  def linefront_whitespace_eliminated_string(str)
    str.gsub(/^\s*/m, "")
  end

  # @param str String
  # @return String
  def linefront_comment_symbol_eliminated_string(str)
    str.gsub(/^\**/m, "")
  end
end