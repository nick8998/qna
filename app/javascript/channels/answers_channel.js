import consumer from "./consumer"

consumer.subscriptions.create("AnswersChannel", {
  connected(data) {
  	this.perform("follow", data)
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
  	$(".answers").append('<p>' + data['answer'].body + '</p>')
  }
});
