import consumer from "./consumer"

consumer.subscriptions.create("CommentableChannel", {
  connected(data) {
    this.perform("follow", data);
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
  	console.log(data)
  	//я написал Виталию, он сказал, что действительно есть проблема со ским и посоветовал handlebars, но если не выйдет с ним, можно так отрендерить.
    $('.comments[data-type="'+data['comment'].commentable_type+'"][data-id="'+data['comment'].commentable_id+'"]').append('<p>' + data['comment'].body + '</p>')
  }
});
