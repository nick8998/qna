$(document).on('turbolinks:load', function(){
   $('.question').on('click', '.edit-question-link', function(e) {
		e.preventDefault();
		$(this).hide();
		var questionId = $(this).data('questionId');
		$('form#edit-question-' + questionId).removeClass('hidden');
   })
   $('.question').on('click', '.create-comment-for-question-link', function(e) {
		e.preventDefault();
		$(this).hide();
		var questionId = $(this).data('questionId');
		$('form#create-comment-for-question-' + questionId).removeClass('hidden');
   })
});