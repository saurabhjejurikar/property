<%@page import="net.property.search.Searcher"%>
<%@ include file="includes/include.jsp" %>  
<%@ taglib prefix="str" uri="http://jakarta.apache.org/taglibs/string" %>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<c:url value="/assets/css/search.css" />" rel="stylesheet">
<%-- <jsp:include page="includes/css.jsp?file=search"></jsp:include>	 --%>
<jsp:include page="includes/css.jsp"></jsp:include>
<title>${model.page_title} - PropertySeeker</title>
</head>
<body>
   	<jsp:include page="includes/top_bar.jsp"></jsp:include>	
	<div class="container" id="primary"> <!--  Holds the primary content -->
		<div>
			<div id="search-logo" class="col-sm-4 col-md-3">
				<a href="/" title="propertySeeker - Find the property of your dream" ><img title="propertySeeker" alt="propopertySeeker - some nice tag line" src="assets/img/propertyseeker.PNG"></a>
			</div>
			<div id="search-form" class="col-sm-7 col-md-6">
				<form  name="search" id="search" action="search.html" class="form-horizontal" role="form">
					<input type="hidden" id="loc_id" name="id" value="">
					<div class="col-sm-6 col-md-6" id="location-search">
				    	<div class="right-inner-addon">
							<span class="glyphicon glyphicon-map-marker"></span>
							<input type="text" class="form-control" name="f_l" id="location" placeholder="e.g Wan chai, Mong Kok" value="${model.location}">
					  	</div>
				  	</div>
				  	<div class="col-sm-4 col-md-4" id="type-search">
				  		<select name="t" class="form-control">
				  			<option <c:if test="${model.type == 1}">selected="selected"</c:if>value="2">For Sale</option>
				  			<option <c:if test="${model.type == 2}">selected="selected"</c:if>value="1">To Rent</option>
				  		</select>
				  	</div>
				  	<div class="col-sm-2 col-md-2">
				  		<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span> Find</button>
				  	</div>
				  	<div class="sort" style="display:block;">
				  	</div>
				</form>
				<div style="font-size: 12px;">
					Popular searches: <a href="search.html?id=12078&f_l=London&t=1">Wan Chai</a>, <a href="search.html?id=8262&f_l=manchester&t=1">North Point</a>, <a href="search.html?id=21062&f_l=birmingham&t=1">Lohas Park</a>, <a href="search.html?id=12716&f_l=liverpool&t=1">Mong Kok</a>
				</div>
			</div>
		</div>
		
		<div class="container hidden-xs">
			<div id="" class="row">
				<div class="col-sm-12 col-md-12">
					<h1>${model.page_title}</h1>
				</div>
			</div>
		</div>
		
		<div class="container"> <!--  Comes from bootsrap up to 12 columns -->
			<jsp:include page="includes/left_sidebar.jsp"></jsp:include>
		  	<c:if test="${model.error == 'no_matching'}"><jsp:include page="includes/no_results.jsp"></jsp:include></c:if>
		  	<c:if test="${empty model.error}"><jsp:include page="includes/results.jsp"></jsp:include></c:if>
		  	<jsp:include page="includes/right_sidebar.jsp"></jsp:include>		  	
		</div>
	</div>
	<jsp:include page="includes/footer.jsp"></jsp:include>
	<script type="text/javascript" src="assets/js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="assets/js/bootstrap-slider.js"></script>
	<script type="text/javascript" src="assets/js/jquery-ui-1.10.4.custom.js"></script>
	<script type="text/javascript">
		$.fn.exists = function () {
		    return this.length !== 0;
		};
		
		$(document).ready(function() {
			$(".filtered").show();
			$(".filtered").parents().show();
			if($(".filtered").parent().find("ul").find("li").exists())
				$(".filtered").parent().find("ul").find("li").slice(0,10).show();
			else
				$(".filtered").parent().siblings().slice(0,10).show();		
		});
		

		$("#see_more").click(function(e) {
			$(".filtered").parent().find("ul").find("li").slice(0,20).show();
			$(this).hide();
			e.preventDefault();
		});
	
		$("#location").autocomplete({
	        source: function( request, response ) {
	        	var q = $('#location').val();
	            $.getJSON("sugg-location.html?q=" + encodeURI(q), response);
	        },
	      	focus: function( event, ui ) {
	    		return false;
	    	},
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
	    		console.debug("ID: " + ui.item.id);
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
		
		$('.slider').slider().on("slide", function(e) {
			var price = $(this).val().split(",");
			var lowerPrice = price[0];
			var upperPrice = price[1];
			if(lowerPrice != undefined && upperPrice != undefined) {
				$("#price-start").text(getRepString(lowerPrice));
				$("#price-end").text(getRepString(upperPrice));
			}
		})
		.on("slideStop", function(e) {
			var price = $(this).val().split(",");
			var lowerPrice = price[0];
			var upperPrice = price[1];
			if(lowerPrice != undefined && upperPrice != undefined){
				var newUrl = setGetParameter('f_pl',lowerPrice, window.location.href);
				newUrl = setGetParameter('f_pu',upperPrice, newUrl);
				window.location.href = newUrl;
			}
		});
		
		// Changing the sorting order
		$("select[name='s']").change(function(e) {
			var sort = $(this).find("option:selected").val();
			window.location.href = setGetParameter('<%=Searcher.FILTER_SORT%>',sort, window.location.href);
		});
		
		function getRepString (rep) {
		    rep = rep+''; // coerce to string
		    if(rep > 1000000) {
		    	<c:if test="${model.type == 2}">
		    	if(rep == <%=Searcher.SELL_UPPER_LIMIT%>)
		    		return (rep/1000000).toFixed(1)+'M+';
		    	</c:if>
		    	return (rep/1000000).toFixed(2)+'M';
		    } else if (rep > 1000) { // place a comma between
		    	<c:if test="${model.type == 1}">
		    	if(rep == <%=Searcher.RENT_UPPER_LIMIT%>)
		    		return (rep/1000).toFixed(1)+'k+';
		    	</c:if>
		    	<c:if test="${model.type == 2}">
		    		return (rep/1000).toFixed(0)+'k';
		    	</c:if>
		    	<c:if test="${model.type == 1}">
		    		return (rep/1000).toFixed(1)+'k';
		    	</c:if>
		    }
		    // divide and format
		    return rep;
		};
		
		$("#buttonFilter").click(function(e) {
			var newUrl = window.location.href;
			newUrl = setGetParameter("<%=Searcher.FILTER_GROSS_AREA_LOWER%>", $("[name='<%=Searcher.FILTER_GROSS_AREA_LOWER%>']").val(), newUrl);
			newUrl = setGetParameter("<%=Searcher.FILTER_GROSS_AREA_UPPER%>", $("[name='<%=Searcher.FILTER_GROSS_AREA_UPPER%>']").val(), newUrl);
			window.location.href = newUrl;
		});
		
		$("#buttonFilterSaleable").click(function(e) {
			var newUrl = window.location.href;
			newUrl = setGetParameter("<%=Searcher.FILTER_SALEABLE_AREA_LOWER%>", $("[name='<%=Searcher.FILTER_SALEABLE_AREA_LOWER%>']").val(), newUrl);
			newUrl = setGetParameter("<%=Searcher.FILTER_SALEABLE_AREA_UPPER%>", $("[name='<%=Searcher.FILTER_SALEABLE_AREA_UPPER%>']").val(), newUrl);
			window.location.href = newUrl;
		});
		
		function setGetParameter(paramName, paramValue, url)
		{
		   // var url = window.location.href;
		    if (url.indexOf(paramName + "=") > 0)
		    {
		        var prefix = url.substring(0, url.indexOf(paramName+"="));
		        var suffix = url.substring(url.indexOf(paramName+"="));
		        suffix = suffix.substring(suffix.indexOf("=") + 1);
		        suffix = (suffix.indexOf("&") >= 0) ? suffix.substring(suffix.indexOf("&")) : "";
		        url = prefix + paramName + "=" + paramValue + suffix;
		    }
		    else
		    {
		    if (url.indexOf("?") < 0)
		        url += "?" + paramName + "=" + paramValue;
		    else
		        url += "&" + paramName + "=" + paramValue;
		    }
		    return url;
		}
		
		function removeURLParameter(parameter , url) {
		    //prefer to use l.search if you have a location/link object
		    var urlparts= url.split('?');   
		    if (urlparts.length>=2) {

		        var prefix= encodeURIComponent(parameter)+'=';
		        var pars= urlparts[1].split(/[&;]/g);

		        //reverse iteration as may be destructive
		        for (var i= pars.length; i-- > 0;) {    
		            //idiom for string.startsWith
		            if (pars[i].lastIndexOf(prefix, 0) !== -1) {  
		                pars.splice(i, 1);
		            }
		        }

		        url= urlparts[0]+'?'+pars.join('&');
		        return url;
		    } else {
		        return url;
		    }
		}
		function removeAreaFilter(param1,param2){
			var newUrl = removeURLParameter(param1, window.location.href);
				newUrl = removeURLParameter(param2, newUrl);
			window.location.href = newUrl;
		}
		function bedroomFilter(bedroomCount){
			window.location.href = setGetParameter("<%=Searcher.FILTER_ROOMS%>", bedroomCount, window.location.href);
		}
	</script>
	<jsp:include page="includes/tracking.jsp"></jsp:include>
</body>
</html>