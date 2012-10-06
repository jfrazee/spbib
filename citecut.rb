require 'set'
require 'bibtex'

# Usage: ruby citecut.rb <latex> <bib>

# Get the citekeys used in the LaTeX doc
citekeys = Set.new
open(ARGV[0]).readlines.each do |line|
  line.scan(/\\\w*cite\w*{([\w\d,:-]+)}/) do |c|
    citekeys.merge c[0].split(',')
  end
end

# Create a new .bib file w/ only the used entries
bib = BibTeX.open(ARGV[1])
citekeys.sort.each do |c|
  if bib[c].nil?     
    bib.each do |entry|
      if entry.key.downcase == c.downcase
        entry.key = c 
        warn "updating citekey: #{c}"
        break 
      end
    end
  end
  puts "#{bib[c]}\n"
end