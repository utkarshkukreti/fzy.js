fzy = {}

module?.exports = fzy: fzy
window?.fzy = fzy

fzy.sort = (haystacks, needle) ->
  haystacks.map (haystack, index) ->
    index: index, haystack: haystack, score: fzy.score haystack, needle
  .sort (left, right) ->
    # Ascending sort by index
    if left.score == right.score
      left.index - right.index
    # Descending by score
    else
      right.score - left.score
  .map (object) ->
    object.haystack

leadingCharacterBonus = [5, 3, 1, 0.5, 0.5, 0.5]

fzy.score = (haystack, needle) ->
  return Infinity if haystack == needle
  score = 0
  lNeedle = needle.toLowerCase()
  lHaystack = haystack.toLowerCase()
  i = 0; lastIndex = 0
  while i < needle.length
    j = lHaystack.indexOf(lNeedle[i], lastIndex)
    if j < 6
      score += leadingCharacterBonus[j]

    if j == -1
      return 0

    # Consecutive match.
    if j == lastIndex + 1
      score++

    # Current character is a capital letter.
    if "A" <= haystack[j] <= "Z"
      score++

    # Previous character is one of: -_/.
    if j > 0 and /[-_\/\.]/.test haystack[j - 1]
      score++

    lastIndex = j + 1
    i++

  score
