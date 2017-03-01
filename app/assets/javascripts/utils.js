var Utils = {};

Utils.init = function() {
	Utils.start_bs_admin();
};

Utils.start_bs_admin = function() {
	//Loads the correct sidebar on window load, collapses the sidebar on window resize. Sets the min-height of #page-wrapper to window size
	var bs = function() {
		$('#side-menu').metisMenu();
		var topOffset = 50;
		var width = (window.innerWidth > 0) ? window.innerWidth : screen.width;
		if (width < 768) {
			$('div.navbar-collapse').addClass('collapse');
			topOffset = 100; // 2-row-menu
		} else {
			$('div.navbar-collapse').removeClass('collapse');
		}
		var height = ((window.innerHeight > 0) ? window.innerHeight : screen.height) - 1;
		height = height - topOffset;
		if (height < 1) height = 1;
		if (height > topOffset) {
			$("#page-wrapper").css("min-height", (height) + "px");
		}
	};
	$(window).bind("load resize", bs);
	document.addEventListener("turbolinks:load", bs);
	//var url = window.location;
	//var element = $('ul.nav a').filter(function() {
	//	return this.href == url;
	//}).addClass('active').parent();
	//while (true) {
	//	if (element.is('li')) {
	//		element = element.parent().addClass('in').parent();
	//	} else {
	//		break;
	//	}
	//}
}

Utils.notification = function(n_class, text) {
	var $notification = $('<div>', { class: 'notification', text: text }).addClass(n_class).hide();
	$('body').append($notification);
	setTimeout(function() {
		$notification.fadeIn(function() {
			setTimeout(function() {
				$notification.fadeOut(function() {
					$notification.remove();
				});
			}, 4000);
		});
	}, 100);
};

Utils.autonumeric = function() {
	$('input.autonumeric').autoNumeric('init', { aSep: '.', aDec: ',', aPad: false });
	$('input.autonumeric-price').autoNumeric('init', { aSep: '.', aDec: ',', aPad: 2 });
};

$(Utils.init);