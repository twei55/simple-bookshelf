function removeAuthor (link) {
	console.log(link);
	$(link).previous("input[type=hidden]").value = "1";
	$(link).up(".fields").hide();
}

function addNewAuthor (link) {
	var clone = $('new_author_fields').innerHTML;
	var new_id = new Date().getTime();	// generate unique index
	var regexp = new RegExp("new_authors", "g");
	clone = clone.replace(regexp, new_id);
	$(link).up().insert({
		before: clone
	});
  }

//
var BookForm = Class.create ({
	
	observeTitleField : function () {
		$('book_title').observe('keyup',function(evt) {
			if ($F('book_title').length > 2 && $F('book_title').endsWith(" ")) {
				this.getBooksWithSimilarTitles();
			}
		}.bind(this));
	},
	
	getBooksWithSimilarTitles : function () {
		var url = "/books/similar";
		new Ajax.Request(url, {
			method: 'get',
			parameters: "title=" + $F('book_title'),
			onSuccess: this.onListSuccess.bind(this),
			onFailed: this.onListFailed.bind(this),
			onLoading: this.onListLoading.bind(this)
		});
	},
	
	onListSuccess : function (res) {
		if (res && !res.responseText.empty()) {
			$('similar_books').update(res.responseText);
			$('similar_books').show();
		}
		else {
			$('similar_books').update("");
			$('similar_books').hide();	
		}
	},
	
	onListFailed : function (res) {
		
	},
	
	onListLoading : function (res) {
		
	}
});