//= require cable
//= require_self
//= require_tree .

App.Socket = App.cable.subscriptions.create('EpicsChannel', {
  received: function(data) {
    $(`#epic-${data.epic.id}`).replaceWith(data.html)
  },
})
