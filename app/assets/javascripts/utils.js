var Utils = {};

Utils.init = function() {
	if ($('body>div#wrapper').length) {
		Utils.start_bs_admin();
		Utils.collectionMethods();
	} else {
		Utils.mobileNav();
		Utils.scrollHash();
		Utils.simpleSlider();
		Utils.radios.init();
		$(document).on('submit', 'form.trigger-loader', function(e) {
			if ($(this).valid()) Utils.loader();
		});
	};
	Utils.checkboxes.init();
};

Utils.collectionMethods = function() {
	$(document).on('submit', 'form.collection-methods', Utils.loader);
	$(document).on('change', 'input[type=checkbox].collection-methods', function(e) {
		var $checked = $('input[type=checkbox].collection-methods:checked');
		$('form.collection-methods :submit').prop('disabled', !$checked.length);
		$('form.collection-methods').each(function() {
			var $form = $(this);
			var $fieldset = $form.find('span').length ? $form.find('span') : $('<span>').appendTo($form);
			$fieldset.html(null);
			$checked.each(function() {
				$('<input>', { type: 'hidden', name: 'ids[]', value: $(this).val() }).appendTo($fieldset);
			});
		});
	});
};

Utils.media = function(device, callback) {
	var devices = { mobile: '(max-width: 767px)', tablet: '(max-width: 991px)', laptop: '(max-width: 1199px)' };
	if (typeof device === 'function') {
		for (var key in devices) window.matchMedia(devices[key]).addListener(device);
	} else if (!!devices[device] && !!callback) {
		window.matchMedia(devices[device]).addListener(callback);
	} else if (!!devices[device]) {
		for (var key in devices) { if (window.matchMedia(devices[key]).matches) return key == device; }; return false;
	} else if (device == 'desktop') {
		return window.matchMedia('(min-width: 1200px)').matches;
	} else {
		for (var key in devices) { if (window.matchMedia(devices[key]).matches) return key; }; return 'desktop';
	}
};

Utils.simpleSlider = function() {
	$(document).on('swipeleft', '.simpleSlider', function(e) {
		var $slider = $(e.target).closest('.simpleSlider');
		$slider.addClass('right');
	});
	$(document).on('swiperight', '.simpleSlider', function(e) {
		var $slider = $(e.target).closest('.simpleSlider');
		$slider.removeClass('right');
	});
};

Utils.mobileNav = function() {
	$(document).on('click', '.mobile-nav-trigger', function(e) {
		e.preventDefault();
		$('body').toggleClass('mobile-nav-active');
	});
	$(document).on('click', '.mobile-nav-active .pages-wrapper', function(e) {
		$('body').removeClass('mobile-nav-active');
	});
	$(document).on('tap', '.mobile-nav-active .pages-wrapper', function(e) {
		$('body').removeClass('mobile-nav-active');
	});
	Utils.media('mobile', function() {
		$('body').removeClass('mobile-nav-active');
	});
};

Utils.scrollHash = function() {
	$(document).on('click', '.scroll-hash', function(e) {
		e.preventDefault();
		var $this = $(this);
		var target_id = $this.attr('href').substr(1);
		var $target = $(target_id);
		var $body = $('html, body');
		if ($target.length && !$body.hasClass('mobile-nav-active')) {
			$body.animate({ scrollTop: $target.offset().top }, 300);
		} else {
			if (window.location.pathname == '/') $('body').removeClass('mobile-nav-active');
			window.location.href = '/' + target_id;
		};
	});
};

Utils.radios = function() {
	$('.radio-inline>input[type=radio]').each(function() {
		if (this.checked) $(this).parent().addClass('active');
	});
};

Utils.radios.init = function() {
	$(document).on('change', '.radio-inline>input[type=radio]', function(e) {
		var target = this;
		$('input[type=radio]').filter(function() {
			return target.name == this.name;
		}).parent().removeClass('active');
		$(this).parent().addClass('active');
	});
};

Utils.checkboxes = function() {
	$('.checkbox-inline>input[type=checkbox]').each(function() {
		if (this.checked) $(this).parent().addClass('active');
	});
	$('.checkbox-inline>input[type=checkbox][name=select_all]').each(function() {
		var element = this;
		var selector = $(element).data('target');
		var $targets = $('input[type=checkbox]'+selector);
		if ($targets.filter(':checked').length == $targets.length) $(element).prop('checked', true).parent().addClass('active');
		$targets.data('master', element);
	});
};

Utils.checkboxes.init = function() {
	$(document).on('change', '.checkbox-inline>input[type=checkbox]', function(e) {
		$(this).parent().toggleClass('active');
		var master = $(this).data('master');
		if (master) {
			if (master.checked && !this.checked) $(master).prop('checked', false).parent().removeClass('active');
			else if (!master.checked) {
				var selector = $(master).data('target');
				var $targets = $('input[type=checkbox]'+selector);
				if ($targets.filter(':checked').length == $targets.length) $(master).prop('checked', true).parent().addClass('active');
			};
		};
	});
	$(document).on('change', '.checkbox-inline>input[type=checkbox][name=select_all]', function(e) {
		var element = this;
		var selector = $(element).data('target');
		var $targets = $('input[type=checkbox]'+selector);
		$targets.filter(function() {
			return $(element).is(':checked') != $(this).is(':checked');
		}).click();
	});
};

Utils.mp = function(href, params) {
	//PAYMENT CON INFO HECHO SIN MODO SAND_BOX PARA RPBAR NOTIFICATIONS
	//$.post('/payments/notifications?topic=payment&id=2408127797', 'json').done(function(){console.log(arguments)})
	var loader = Utils.loader();
	var member_url = function(id) {
		return href + '/' + id;
	};
	var delete_payment = function(id) {
		loader.show();
		$.ajax(member_url(id), { method: 'delete', dataType: 'json', timeout: 15000 })
		.always(loader.hide);
	};
	var update_payment = function(id, data) {
		loader.show();
		$.ajax(member_url(id), { method: 'patch', dataType: 'json', timeout: 15000, data: { payment: data } })
		.always(function(response) {
			window.location.href = member_url(id);
		});
	};
	var open_modal = function(response) {
		loader.hide();
		$MPC.openCheckout ({
			url: response.init_point,
			mode: 'modal',
			onreturn: function(data) {
				var payment_id = data.external_reference;
				if (!data.collection_id) delete_payment(payment_id);
				else update_payment(payment_id, data);
			}
		});
	};
	$.post(href, params, open_modal, 'json');
};

Utils.loader = function() {
	var $loader = $('body>div.loader');
	var show = function() {
		$loader = $('<div>', { class: 'loader' }).hide();
		$('body').addClass('overflow-hidden').append($loader);
		setTimeout(function() {
			$loader.fadeIn();
		}, 100);
	};
	var hide = function() {
		$loader.fadeOut(function() {
			$('body').removeClass('overflow-hidden');
			$loader.remove();
		});
	};
	if (!$loader.length) show();
	return { element: $loader, hide: hide, show: show };
};

Utils.start_bs_admin = function() {
	//Loads the correct sidebar on window load, collapses the sidebar on window resize. Sets the min-height of #page-wrapper to window size
	var bs = function() {
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
	$(document).on("turbolinks:load", function() {
		$('#side-menu').metisMenu();
	});
	$(document).on("turbolinks:load", bs);
	$(window).bind("load resize", bs);
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

Utils.filtersForm = function() {
	var $form = $('#filters_form');
	var $input = $('#f_order');
	var current_order = $input.val() == '' ? false : $input.val();
	$('[data-order]').click(function(e) {
		e.preventDefault();
	  var $this = $(this);
	  var order = $this.data('order');
	  var new_order, match;
	  if (current_order && (match = current_order.match(new RegExp(order + '_(asc|desc)')))) {
	    var current_dir = match[1];
	    var dir = current_dir == 'asc' ? 'desc' : 'asc';
	    new_order = order + '_' + dir;
	  } else {
	    new_order = order + '_asc';
	  };
	  $input.val(new_order);
	  $form.submit();
	});
};

Utils.insertFormResponse = function(form, text, fadeOutDelay) {
	var $response = $('<div>', { class: 'form-js-response' }).height(form.scrollHeight).hide();
	var $va = $('<div>', { class: 'vertical-align' }).append($('<div>', { class: 'middle', html: text }));
	$(form).after($response.append($va));
	$response.fadeIn();
	if (typeof fadeOutDelay === 'number' || fadeOutDelay === true) {
		setTimeout(function() {
			$response.fadeOut(function() {
				$response.remove();
			});
		}, fadeOutDelay || 3000);
	};
};

$(Utils.init);