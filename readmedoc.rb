#!/usr/bin/ruby -w

require_relative 'lib/readme_doc'

include_pattern = ARGV[0]

doc = ReadmeDoc.new
puts doc.document_with_glob_pattern("**/*#{include_pattern}")