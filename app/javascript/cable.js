import cable from "actioncable";

(function() {
  this.App || (this.App = {});

  App.cable = cable.createConsumer();
}.call(this));