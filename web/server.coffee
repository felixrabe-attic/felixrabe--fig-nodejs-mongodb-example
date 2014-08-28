#!/usr/bin/env coffee

require 'coffee-script/register'
ListStorage = require('./liststorage-mongodb').ListStorage
listStorage = new ListStorage

handlebars = require 'handlebars'

index = handlebars.compile '''
  <title>List</title>
  <h1>List</h1>
  <ul>
    {{#each items}}
      <li><a href="/delete/{{_id}}">[&times;]</a> {{item}}</li>
    {{/each}}
  </ul>
  <form method="POST">
    <label>Add something:</label>
    <input name="item" autofocus="autofocus" />
    <input type="submit" value="Submit" />
  </form>
'''

express = require 'express'
bodyParser = require 'body-parser'
app = express()

app.use bodyParser.urlencoded extended: true

app.get '/', (req, res) ->
  listStorage.toArray (err, items) ->
    throw err if err
    res.send index items: items

app.post '/', (req, res) ->
  listStorage.push req.body.item, (err) ->
    throw err if err
    res.redirect '/'

app.get '/delete/:_id', (req, res) ->
  listStorage.remove req.params._id, (err) ->
    throw err if err
    res.redirect '/'

app.listen 8080
