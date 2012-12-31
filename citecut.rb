#!/usr/bin/env ruby
require 'bibtex'

# Usage: ruby citecut.rb <latex> <bib>

# Get the cite keys from the LaTeX document
citekeys = open(ARGV[0]).read.scan(/\\\w*cite\w*\{([^}]+)\}/).flat_map { |citation_group|
  citation_group[0].split(/\s*,\s*/)
}.uniq.sort

# Create a new .bib file with only the used entries
bib = BibTeX.open(ARGV[1])
citekeys.each do |citekey|
  bib.each do |entry|
    if entry.key.downcase == citekey.downcase
      if entry.key != citekey
        entry.key = citekey
        warn "updating citekey: #{citekey}"
      end
      puts "#{bib[citekey]}\n"
    end
  end
end