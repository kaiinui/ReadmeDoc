require 'rake/file_list'
require_relative 'processor'

class ReadmeDoc
  # @param include_pattern [String] The pattern of Dir#glob
  # @param exclude_patterns [Array<String>] The patterns of Dir#glob
  # @param repo [String] Repo path
  # @return [String] documents
  def document_with_glob_pattern(include_pattern, exclude_patterns, repo)
    files_from_patterns(include_pattern, exclude_patterns).map { |filepath|
      next unless readme_annotated?(filepath)

      filename = filepath.split("/").last
      s = "## " + filename.split(".")[0] # Heading
      s += "\n\n"
      s += Processor.new.readme_document_from_file(filepath) # Body
      s += "\n"
      s += link_to_github(filepath, repo) # Refer [URL]
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

  def link_to_github(filepath, repo)
    filename = filepath.split("/").last

    "[Refer #{filename}](https://github.com/#{repo}/blob/master/#{filepath})"
  end
end