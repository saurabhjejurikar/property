<%@ include file="includes/include.jsp" %>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="includes/css.jsp?file=home"></jsp:include>	
<meta name="description" content="PropertySeeker - A nice description"/>
<title>PropertySeeker - A nice description</title>
</head>
<body>
	<jsp:include page="includes/top_bar.jsp"></jsp:include>	
	<div id="primary"> <!--  Holds the primary content -->
		<!--
			The Logo.
			Size is 425px width
			Center Aligned 
		 -->
		<div id="home-logo">
			<a href="/" title="PropertySeeker - A nice description" ><img title="propertySeeker" alt="propertySeeker - A nice Description" src="assets/img/propertyseeker.PNG"></a>
		</div>
		
		<!--
			The form on the home page.
			Background white.
		 -->
		<div id="search-form" class="bg-grey text-center">
			<form name="search" id="search" action="search.html" class="form-horizontal" role="form">
				<input type="hidden" id="loc_id" name="id" value="">
				<div class="form-group right-inner-addon">
					<span class="glyphicon glyphicon-map-marker lead"></span>
					<input type="text" class="form-control input-lg" name="f_l" id="location" placeholder="e.g. Wan Chai, North Point">
			  	</div>
			  	<div style="margin-bottom: 25px; font-size: 12px;">
			  		Popular searches: <a href="search.html?id=26&t=1">Wan Chai</a>, <a href="search.html?id=12&t=1">North Point</a>, <a href="search.html?id=40&t=1">Mong Kok</a> 
			  	</div>
			  	<div class="form-group">
		  			<button type="submit" class="btn btn-lg btn-primary" name="t" value="2">For Sale</button>
		    		<button type="submit" class="btn btn-lg btn-primary" name="t" value="1">To Rent</button>
			    </div>			    
			    <h1>
					<fmt:formatNumber maxFractionDigits="0" value="${model.total}"/> Hong Kong properties for sale and rent in the last month
				</h1>				
			</form>
		</div>
	</div>
	<script type="text/javascript" src="assets/js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="assets/js/jquery-ui-1.10.4.custom.js"></script>
	<script type="text/javascript">
		$("#location").autocomplete({
	        source: function( request, response ) {
	        	var q = $('#location').val();
	            $.getJSON("sugg-location.html?q=" + encodeURI(q), response);
	        },
	      	/* focus: function( event, ui ) {
	    		return false;
	    	}, */
	    	delay: 0,
	    	open: function(event, ui) {
	            //using the 'open' event to capture the originally typed text
	            var self = $(this), val = self.val();
	            //saving original search term in 'data'.
	            self.data('searchTerm', val);
	        },
	    	select: function( event, ui ) {
	    		var self = $(this),
	               keyPressed = event.keyCode,
	               keyWasEnter = event.keyCode === 13,
	               useSelection = true,
	               val = self.data('searchTerm');
	    		$("#location").val(ui.item.value);
	    		$("#loc_id").val(ui.item.id);
	    		if (keyPressed) {
	                if (keyWasEnter) {
	                    useSelection = true;
	                    event.preventDefault();
	                    window.setTimeout(function() {
	                        $('form#search').submit();
	                    }, 0);
	                }
	            }
	            return useSelection;
	    	}
	    }).data( "ui-autocomplete" )._renderItem = function( ul, item ) {
	    	ul.addClass("query-autocomplete");
	    	var re = new RegExp("^" + $("#location").val(), "i");
	    	return $( "<li>" )
	    		.data( "ui-autocomplete-item", item )
	    	    .append("<a>" + item.value.replace(re,"<b>$&</b>") + "</a>")
	    	    .appendTo( ul );
	    };
	</script>
	<jsp:include page="includes/tracking.jsp"></jsp:include>
</body>
</html>