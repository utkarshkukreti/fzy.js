fzy = require("../lib/fzy").fzy

chai = require "chai"
chai.Assertion.includeStack = true
expect = chai.expect

describe "fzy", ->
  inputs = [
    ".gitignore"
    "Gemfile"
    "LICENSE.txt"
    "README.md"
    "Rakefile"
    "bin/ln2"
    "lib/ln2.rb"
    "lib/ln2/Guardfile"
    "lib/ln2/version.rb"
    "lib/ln2/watchers.rb"
    "ln2.gemspec"
  ]

  it "works on files", ->
    f = (needle, haystack) ->
      expect(fzy.sort(inputs, needle)[0]).to.eq haystack

    f "", ".gitignore"
    f ".g", ".gitignore"
    f "g", "Gemfile"
    f "rf", "Rakefile"
    f "b/l", "bin/ln2"
    f "lb", "lib/ln2.rb"
    f "gsp", "ln2.gemspec"
    f "ln2", "ln2.gemspec"
    f "m", "README.md"

  it "returns at most options.limit results", ->
    expect(fzy.sort(inputs, "", limit: 3)).to.have.length 3
    expect(fzy.sort(inputs, "", limit: 100)).to.have.length inputs.length

  it "wraps results in options.wrap tag", ->
    expect(fzy.sort(inputs, "gf", wrap: "em")[0]).
      to.eq "<em>G</em>em<em>f</em>ile"
    expect(fzy.sort(["aabbcc"], "abc", wrap: "em")[0]).
      to.eq "<em>a</em>a<em>b</em>b<em>c</em>c"
