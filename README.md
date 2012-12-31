# Citation management:

First, install the `bibtex-ruby` gem.

    gem install bibtex-ruby

Then use the `citecut.rb` script, like so:

    ruby citecut.rb paper.tex allcitations.bib > paper.bib

It'll go through the `TeX` file, finding all commands that contain `cite` in the name of the command, and extract the contents, splitting on commas.

Then it filters through all the citations in the `allcitations.bib` file, only keeping the the ones cited in `paper.tex` (the search is case-insensitive, but for non-case-exact matches, it coerces the BibTeX entry to match the actual cited case).

It then prints all of these to `STDOUT`, sorted naturally on the citation key. It lowercases the citation type, like `@article`, or `@inproceedings`, standardizes indentation, and purges all comments. It is more picky about the formatting than TeX, and only gives token-location (not line number) on parse errors. But it preserves the exact contents of fields, as well as ordering.
