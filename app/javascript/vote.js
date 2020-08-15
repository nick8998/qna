$(document).on('turbolinks:load', function(){
   $('.voting').on('ajax:success', function(e) {
      console.log(e);
   })
   		.on('ajax:error', function(e){
   			var errors = e.detail[0];

   			$.each(errors, function(index, value) {
   				$(".answer-errors").append('<p>' + value + '</p>');
   			})
   			
   		})

});