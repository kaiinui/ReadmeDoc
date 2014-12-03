class ReadmeDoc
  # @param pattern String The pattern of Dir#glob
  # @param repo String Repo path
  # @return String
  def document_with_glob_pattern(pattern, repo)
    puts Dir.glob("**/*.h").map { |filename|
      s = "## " + filename.split("/").last.split(".")[0]
      s += "\n\n"
      s += readme_document_from_file(filename)
      s += "\n"
      s += link_to_github(filename, repo)
      s += "\n"
      s
    }.join("\n")
  end

  private

  def link_to_github(filename, repo)
    "[Refer #{filename}](https://github.com/#{repo}/blob/master/#{filename}#L23)"
  end

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

  # Returns @readme annotated statement from a file that specified by given filename.
  #
  # @param filename String The name of file
  # @return String
  def readme_document_from_file(filename)
    body = File.open(filename).read
    statements = readme_annotated_statements(body)
    statements.map { |s|
      no_white = linefront_whitespace_eliminated_string(s)
      no_comment = linefront_comment_symbol_eliminated_string(no_white)
      linefront_whitespace_eliminated_string(no_comment)
    }.join("\n")
  end
end