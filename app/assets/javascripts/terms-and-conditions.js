var TermsAndConditions = {};

TermsAndConditions.init = function(apiUrl) {
	if ($('#terms-and-conditions').hasClass('terms-and-conditions-started'))
		return;

	this.apiUrl = apiUrl;
	$('#terms-and-conditions').addClass('terms-and-conditions-started');
	this.index();
}

TermsAndConditions.index = function() {
	$.get(this.apiUrl + '/data/terms_and_conditions', null, function(response, status, xhr) {
		$('#terms-and-conditions').html(response.terms_and_conditions);
	}, 'json');
}