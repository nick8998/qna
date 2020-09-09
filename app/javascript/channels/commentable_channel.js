import consumer from "./consumer"

consumer.subscriptions.create("CommentableChannel", {
  connected(data) {
    this.perform("follow", data);
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    $('.comments[data-type="'+data['comment'].commentable_type+'"][data-id="'+data['comment'].commentable_id+'"]').append('<p>' + data['comment'].body + '</p>')
  }
});
