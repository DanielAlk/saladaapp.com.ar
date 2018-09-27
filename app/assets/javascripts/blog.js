var Blog = {};

var Post = function(data) {
	this.id = data.id;
	this.title = data.title;
	this.text = data.text;
	this.cover = data.cover_url;
	this.date = moment(data.updated_at).format('DD MMM');
}

Blog.init = function(apiUrl) {
	if ($('#articles').hasClass('blog-started'))
		return;
	var _this = this;
	this.apiUrl = apiUrl;
	this.page = 1;
	
	moment.locale('es');
	
	$(document).on('click', '#getPage', function(e) {
		e.preventDefault();
		if ($(this).hasClass('loading'))
			return;
		_this.page += 1;
		_this.index();
	});

	$('#articles').addClass('blog-started');
	this.index();
}

Blog.index = function() {
	var _this = this;
	var button = $('#getPage');
	button.addClass('loading');

	$.get(this.apiUrl + '/posts', { page: this.page, per: 3 }, function(posts, status, xhr) {
		var total = xhr.getResponseHeader('X-Total-Count');
		var pages = Math.ceil(total/3);
		button.removeClass('loading');
		if (_this.page >= pages)
			button.hide();

		posts.forEach(function(p) {
			var post = new Post(p);
			var $article = $('#articleTemplate').clone().removeAttr('id').removeAttr('style');
			$article.find('.article-image img').attr('src', post.cover.medium);
			$article.find('.article-slap span').eq(0).text(post.date.split(' ')[0]);
			$article.find('.article-slap span').eq(1).text(post.date.split(' ')[1]);
			$article.find('.article-title').text(post.title);
			$article.find('.article-text').html(post.text);
			$article.find('a').attr('href', $article.find('a').attr('href').replace('-', post.id));
			$('#articles').append($article);
		})
	}, 'json');
}

Blog.show = function(apiUrl, id) {
	if (moment.locale() != 'es')
		moment.locale('es');
	
	$.get(apiUrl + '/posts/' + id, {}, function(p) {
		var post = new Post(p);
		$('.article-detail-title h4').text(post.date);
		$('.article-detail-title h1').text(post.title);
		$('.article-detail p').html(post.text);
		$('.article-detail img').attr('src', post.cover.large);
	}, 'json')
}