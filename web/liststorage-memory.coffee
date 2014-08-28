# Inspired by http://howtonode.org/express-mongodb

class module.exports.ListStorage
  constructor: ->
    @idCounter = 1
    @list = []

  toArray: (callback) ->
    callback null, @list

  push: (item, callback) ->
    @list.push _id: (@idCounter++).toString(), item: item
    callback null

  remove: (_id, callback) ->
    for item, index in @list
      if item._id == _id
        @list.splice index, 1
        break
    callback null
