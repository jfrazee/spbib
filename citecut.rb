require 'bibtex'

# Usage: ruby citecut.rb <latex> <bib>

# Get the cite keys from the LaTeX document
citekeys = open(ARGV[0]).read.scan(/\\\w*cite\w*{([^},]+,?)+}/).flatten.map(&:strip).uniq.sort

# Create a new .bib file w/ only the used entries
bib = BibTeX.open(ARGV[1])
citekeys.each do |citekey|
  bib.each do |entry|
    if entry.key.downcase == citekey.downcase
      entry.key = citekey
      warn "updating citekey: #{citekey}"
      break
    end
  end if bib[citekey].nil?

  puts "#{bib[citekey]}\n"
end