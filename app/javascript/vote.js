$(document).on('turbolinks:load', function(){
   $('.voting-answer').on('ajax:success', function(e) {

      var vote = e.detail[0];
      var result = vote.votes_up-vote.votes_down

      $('.voting-result').closest('p').fadeOut();
      $('.new-result').append('<p>' + result + '</p>');      
   })
   $('.voting-question').on('ajax:success', function(e) {

      var vote = e.detail[0];
      var result = vote.votes_up-vote.votes_down

      $('.voting-result').closest('p').fadeOut();
      $('.new-result').append('<p>' + result + '</p>');      
   })

});