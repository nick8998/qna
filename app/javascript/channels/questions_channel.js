import consumer from "./consumer"

consumer.subscriptions.create("QuestionsChannel", {
  connected() {
    this.perform("follow") 
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    $(".questions-list").append(data)
  }
});
