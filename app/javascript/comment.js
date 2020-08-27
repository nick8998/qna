$(document).on('turbolinks:load', function(){
   $('.new_commentable').on('ajax:success',function(e) {
   		var resource = e.detail[0]
   		$('.comments[data-type="'+resource.commentable_type+'"][data-id="'+resource.commentable_id+'"]').append(resource.body)
   })
});