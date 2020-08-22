$(document).on('turbolinks:load', function(){
   $('.voting').on('ajax:success', function(e) {

      var vote = e.detail[0];

      $('.voting-result').closest('div').fadeOut();
      $('.new-result').append('<p>' + "Ваш голос " + vote.value + '</p>');      
   })

});