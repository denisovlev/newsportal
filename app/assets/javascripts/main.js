$(function() {
	$('a[data-delete-comment]').on('ajax:success', function(e, data, status, xhr) {
		that = $(e.target);
		that.closest('.comment').find('.comment-body').html('Deleted');
		that.remove();
	});

	$('a[data-delete-article]').on('ajax:success', function(e) {
		that = $(e.target);
		that.closest('.article').remove();
	});
});