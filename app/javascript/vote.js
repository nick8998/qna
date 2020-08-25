$(document).on('turbolinks:load', function(){
   $('.voting-up').on('ajax:success', function(e) {
   		var resource = e.detail[0][0]
   		$('.voting-up[data-type="'+resource.votable_type+'"][data-id="'+resource.votable_id+'"]').addClass('hidden');  
   		$('.voting-down[data-type="'+resource.votable_type+'"][data-id="'+resource.votable_id+'"]').addClass('hidden');  
   		$('.voting-cancel[data-type="'+resource.votable_type+'"][data-id="'+resource.votable_id+'"]').removeClass('hidden');
   	 	var result = parseInt($('.voting-result[data-type="'+resource.votable_type+'"][data-id="'+resource.votable_id+'"]')[0].innerHTML)
   		$('.voting-result[data-type="'+resource.votable_type+'"][data-id="'+resource.votable_id+'"]').html(result+1)

   })
   $('.voting-down').on('ajax:success', function(e) {
   		var resource = e.detail[0][0]   
   		$('.voting-down[data-type="'+resource.votable_type+'"][data-id="'+resource.votable_id+'"]').addClass('hidden');
   		$('.voting-up[data-type="'+resource.votable_type+'"][data-id="'+resource.votable_id+'"]').addClass('hidden');  
   		$('.voting-cancel[data-type="'+resource.votable_type+'"][data-id="'+resource.votable_id+'"]').removeClass('hidden');
   		var result = parseInt($('.voting-result[data-type="'+resource.votable_type+'"][data-id="'+resource.votable_id+'"]')[0].innerHTML)
   		$('.voting-result[data-type="'+resource.votable_type+'"][data-id="'+resource.votable_id+'"]').html(result-1) 
   })
   $('.voting-cancel').on('ajax:success', function(e) {
   		var id = $(this).data("id");
   		var type = $(this).data("type");
   		$(this).addClass('hidden');
   		$('.voting-result[data-type="'+type+'"][data-id="'+id+'"]').html("Голос был отменен")
   })

});