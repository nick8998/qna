$(document).on('turbolinks:load', function(){
   $('.voting-answer').on('ajax:success', function(e) {

      var vote = e.detail[0];

      $('.voting-result').closest('p').fadeOut();
      $('.new-result').append('<p>' + vote.value + '</p>');      
   })
   $('.voting-question').on('ajax:success', function(e) {

      var vote = e.detail[0];

      $('.voting-result').closest('p').fadeOut();
      $('.new-result').append('<p>' + vote.value + '</p>');      
   })

});