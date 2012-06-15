function removeAuthor(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function addNewAuthor(link) {
	var clone = $('div#new_author_fields').html();
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_author_fields", "g");
  $(link).parent().before(clone.replace(regexp, new_id));
}

var BookForm = {
	
	observeTitleField : function () {
		$('#book_title').keyup(function(evt) {
			str = $('#book_title').val();
			if (str.length > 2 && str[str.length-1] == " ") {
				this.getBooksWithSimilarTitles(str.trim());
			}
		}.bind(this));
	},
	
	getBooksWithSimilarTitles : function (str) {
		var jqxhr = $.ajax("/books/similar?title=" + str);
		jqxhr.success(this.showSimilarBooks);
	},

	showSimilarBooks : function (data, textStatus, jqXHR) {
		console.log(data);
		if (data) {
			$('div#similar_books').html(data);
			$('div#similar_books').show();
		}
		else {
			$('div#similar_books').html("");
			$('div#similar_books').hide();
		}
	}
};