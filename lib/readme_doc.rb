require 'rake/file_list'

class ReadmeDoc
  # @param include_pattern String The pattern of Dir#glob
  # @param exclude_pattern Array The patterns of Dir#glob
  # @param repo String Repo path
  # @return String
  def document_with_glob_pattern(include_pattern, exclude_patterns, repo)
    files_from_patterns(include_pattern, exclude_patterns).map { |filepath|
      next unless readme_annotated?(filepath)

      filename = filepath.split("/").last
      s = "## " + filename.split(".")[0] # Heading
      s += "\n\n"
      s += readme_document_from_file(filepath) # Body
      s += "\n"
      s += link_to_github(filename, repo) # Refer [URL]
      s += "\n\n"
      s
    }.join()
  end

  private

  def files_from_patterns(include_pattern, exclude_patterns)
    exclude_patterns = exclude_patterns || []
    list = Rake::FileList[include_pattern]
    exclude_patterns.each do |pattern|
      list = list.exclude("**/#{pattern}")
    end
    list
  end

  # @return if it is @readme annotated
  def readme_annotated?(filepath)
    File.open(filepath).read.include?("@readme")
  end

  def link_to_github(filename, repo)
    "[Refer #{filename}](https://github.com/#{repo}/blob/master/#{filename})"
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