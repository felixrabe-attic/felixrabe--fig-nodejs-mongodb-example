{MongoClient, ObjectID} = require 'mongodb'

class module.exports.ListStorage
  constructor: ->
    @ready = false
    @collection = null
    MongoClient.connect 'mongodb://db_1:27017/list', (err, db) =>
      throw err if err
      db.createCollection 'list', (err, collection) =>
        throw err if err
        @ready = true
        @collection = collection

  toArray: (callback) ->
    return callback new Error 'not ready' unless @ready
    @collection.find().toArray (err, list) ->
      return callback err if err
      callback null, list

  push: (item, callback) ->
    doc = item: item
    @collection.insert doc, {w: 1}, (err, result) ->
      return callback err if err
      callback null

  remove: (_id, callback) ->
    @collection.remove {_id: ObjectID(_id)}, {w: 1}, (err, result) ->
      return callback err if err
      callback null
