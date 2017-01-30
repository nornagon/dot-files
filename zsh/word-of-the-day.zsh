# Fetch a random word definition from Wordnik when opening a new shell.
#
# lough, n.: Irish   A lake.
# lough, n.: Irish   A bay or an inlet of the sea.
#
# Requires jq.
random_word_def() {
  local random_word wordnik_for_word show_definition
  random_word() {
    perl -e 'rand($.) < 1 && ($line = $_) while <>; print $line' < /usr/share/dict/words
  }
  wordnik_for_word() {
    # You should probably get your own API key. It's pretty easy! http://developer.wordnik.com/
    curl -s http://api.wordnik.com/v4/word.json/"$1"/definitions'?api_key=a2a73e7b926c924fad7001ca3111acd55af2ffabf50eb4ae5'
  }
  show_definition() {
    jq -r '
      {
        "null": "?",
        "noun": "n",
        "verb-transitive": "tv",
        "verb-intransitive": "iv",
        "preposition": "prep",
        "verb": "v",
        "adverb": "adv",
        "adjective": "adj"
      } as $short |
      .[] |
      "\(.word), \($short[.partOfSpeech // "null"] // .partOfSpeech).: \(.text)"
    '
  }
  wordnik_for_word "$(random_word)" | show_definition 2>/dev/null
}

# only if running interactively.
if [ "$PS1" -a -x "$(which jq)" ]; then
  [ -f ~/.word_of_the_day ] && fold -s ~/.word_of_the_day
  ( random_word_def >| ~/.word_of_the_day & )
fi
