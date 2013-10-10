$(function() {
	$('.delete-comment').click(function(e) {
		var that = $(this);
		$.ajax({
			url: that.attr('href'),
			type: 'DELETE',
			data: {},
			success: function() {
				that.closest('.comment').find('.comment-body').html('Deleted');
				that.remove();
			},
			dataType: 'json'
		});
		return false;
	});

	$('.delete-article').click(function(e) {
		var that = $(this);
		$.ajax({
			url: that.attr('href'),
			type: 'DELETE',
			data: {},
			success: function() {
				that.closest('.article').remove();
			},
			dataType: 'json'
		});
		return false;
	});
});