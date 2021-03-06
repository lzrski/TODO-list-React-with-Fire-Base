React     = require 'react'
RDOM      = require 'react-dom'
ReactFire = require 'reactfire'
Firebase  = require 'firebase'
Form      = require './Form'
List      = require './List'

db        = new Firebase "https://incandescent-torch-1275.firebaseio.com/"

items     = db.child 'items'

class Hello extends React.Component
  render: ->
    <div className="row panel panel default">
      <div className="col-md-8 col-md-offset-2">
        <h2 className="text-center">
          Messenger
        </h2>

        <Form
          onSubmit = { (value) => items.push value }
          onClear = { => do items.remove }
        />

        <List
          items = { @state.items }
          onClear = { (name) =>
            items
              .child name
              .remove()
          }
        />

      </div>
    </div>

  constructor: ->
    @state = items: {}

  componentWillMount: ->
    items
      .on 'value', (snapshot) =>
        @setState items: snapshot.val()

element = React.createElement Hello
RDOM.render element, document.querySelector '.container'
