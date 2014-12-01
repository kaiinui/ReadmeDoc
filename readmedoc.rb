#!/usr/bin/ruby -w

# @param str String
# @return String
def readme_annotated_statement(str)
  str.match(/@readme([\s\S]*)\/@readme/m).captures[0]
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
  doc = readme_annotated_statement(body)
  nowhite = linefront_whitespace_eliminated_string(doc)
  nocomment = linefront_comment_symbol_eliminated_string(nowhite)
  linefront_whitespace_eliminated_string(nocomment)
end

puts readme_document_from_file("Hoge.h")