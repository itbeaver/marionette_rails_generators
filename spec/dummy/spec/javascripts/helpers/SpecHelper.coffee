# beforeEach ->
#   jasmine.addMatchers toBePlaying: ->
#     { compare: (actual, expected) ->
#       player = actual
#       { pass: player.currentlyPlayingSong == expected and player.isPlaying }
#     }