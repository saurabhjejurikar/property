<%@page import="net.property.search.Searcher"%>
<%@ include file="include.jsp" %>
<%@ taglib prefix="str" uri="http://jakarta.apache.org/taglibs/string" %>
<div id="left-sidebar" class="col-sm-3 col-md-3 hidden-xs">
	<c:if test="${!empty model.has_fitler}">
	<div class="filters_applied">
		<div><b>You filtered by:</b></div>
		<c:forEach var="apply_filter" items="${model.filter_page}">
			<c:if test="${apply_filter.key == 'f_r'}"><div class="filter_applied">Bedroom: ${apply_filter.value} <a href="${model.searchUrl}<c:forEach var="filter_" items="${model.filter_page}"><c:if test="${filter_.key != apply_filter.key}">&amp;${filter_.key}=${filter_.value}</c:if></c:forEach>">(undo)</a></div></c:if>
			<c:if test="${apply_filter.key == 'f_t'}">
				<div class="filter_applied">
					House type: ${apply_filter.value} 
						<a href="${model.searchUrl}<c:forEach var="filter_" items="${model.filter_page}">
						<c:if test="${filter_.key != apply_filter.key}">&amp;${filter_.key}=${filter_.value}</c:if></c:forEach>">(undo)</a></div></c:if>
			<c:if test="${apply_filter.key == 'f_a'}"><div class="filter_applied">${apply_filter.value} 
				<a href="${model.searchUrl}<c:forEach var="filter_" items="${model.filter_page}"><c:if test="${filter_.key != apply_filter.key}">&amp;${filter_.key}=${filter_.value}</c:if></c:forEach>">(undo)</a></div>
			</c:if>
			
			<c:if test="${apply_filter.key == 'f_p'}">
				<c:if test="${apply_filter.value == '1'}"><div class="filter_applied">Last 24 hours <a href="${model.searchUrl}<c:forEach var="filter_" items="${model.filter_page}"><c:if test="${filter_.key != apply_filter.key}">&amp;${filter_.key}=${filter_.value}</c:if></c:forEach>">(undo)</a></div></c:if>
				<c:if test="${apply_filter.value == '3'}"><div class="filter_applied">Last 3 day <a href="${model.searchUrl}<c:forEach var="filter_" items="${model.filter_page}"><c:if test="${filter_.key != apply_filter.key}">&amp;${filter_.key}=${filter_.value}</c:if></c:forEach>">(undo)</a></div></c:if>
				<c:if test="${apply_filter.value == '7'}"><div class="filter_applied">Last 7 days <a href="${model.searchUrl}<c:forEach var="filter_" items="${model.filter_page}"><c:if test="${filter_.key != apply_filter.key}">&amp;${filter_.key}=${filter_.value}</c:if></c:forEach>">(undo)</a></div></c:if>
			</c:if>
			<c:if test="${apply_filter.key == 'f_ga'}"> 
				<div class="filter_applied">
					GrossArea : ${apply_filter.value}
						<a href="javascript:removeAreaFilter('f_gau','f_gal');">(undo)</a>
					</div>
			</c:if>
			<c:if test="${apply_filter.key == 'f_sa'}"> 
				<div class="filter_applied">
					SaleableArea : ${apply_filter.value}
						<a href="javascript:removeAreaFilter('f_sau','f_sal');">(undo)</a>
					</div>
			</c:if>	
			<c:if test="${apply_filter.key == 'f_price'}"> 
				<div class="filter_applied">
					Price : ${apply_filter.value}
						<a href="javascript:removeAreaFilter('f_pl','f_pu');">(undo)</a>
					</div>
			</c:if>	
		</c:forEach>
		<div><a href="${model.searchUrl}&amp;f_l=${model.filtered_location}" class="btn btn-primary">Undo All</a></div>
	</div>
	</c:if>
	
	<div class='filters' id="price_filter">
		<h4>Price</h4>
		<div class="text-muted">HK$<span id="price-start">${model.lower_price}</span> to HK$<span id="price-end">${model.upper_price}</span></div>
		<div style="margin-left: 5px; width: 170px;">
			<input type="text" class="slider" value="" data-slider-min="0" data-slider-max="${model.priceUpperLimit}" 
			data-slider-step="${model.priceStep}" data-slider-value="[${model.lower_price},${model.upper_price}]" data-slider-orientation="horizontal" 
			data-slider-selection="after" data-slider-tooltip="hide" style="width: 90%;">
		</div>
	</div>
	
	<div class='filters'>
		<h4>Location</h4>
		<ul class="text-muted location">
			<c:forEach var="filter" items="${model.location_filters}" varStatus="status1">
				<li style="display:none;"><a<c:if test="${model.filtered_location.equalsIgnoreCase(filter.value)}"><c:set var="hideList" scope="session" value="false"/> class="filtered"</c:if> href="${model.searchUrl}<c:forEach var="apply_filter" items="${model.filter_page}"><c:if test="${apply_filter.key != 'f_l'}">&amp;${apply_filter.key}=<str:encodeUrl>${apply_filter.value}</str:encodeUrl></c:if></c:forEach>&amp;f_l=${filter.value}&amp;f_l_l=1">${filter.value}</a> (<fmt:formatNumber type="number" value="${filter.count}"/>)
				<c:if test="${!empty filter.locationFilters}">
				<ul>
				<c:forEach var="filter2" items="${filter.locationFilters}" varStatus="status2">
					<li style="display:none;"><a<c:if test="${model.filtered_location.equalsIgnoreCase(filter2.value)}"><c:set var="hideList" scope="session" value="false"/>  class="filtered"</c:if> href="${model.searchUrl}<c:forEach var="apply_filter" items="${model.filter_page}"><c:if test="${apply_filter.key != 'f_l'}">&amp;${apply_filter.key}=<str:encodeUrl>${apply_filter.value}</str:encodeUrl></c:if></c:forEach>&amp;f_l=${filter2.value}&amp;f_l=${filter.value}&amp;f_l_l=2">${filter2.value}</a> (<fmt:formatNumber type="number" value="${filter2.count}"/>)
						<ul><c:forEach var="filter3" items="${filter2.locationFilters}" varStatus="status3">
							<c:if test="${status3.index <= 10}">
							<li style="display:none;"><a<c:if test="${model.filtered_location.equalsIgnoreCase(filter3.value)}"><c:set var="hideList" scope="session" value="false"/>  class="filtered"</c:if> href="${model.searchUrl}<c:forEach var="apply_filter" items="${model.filter_page}"><c:if test="${apply_filter.key != 'f_l'}">&amp;${apply_filter.key}=<str:encodeUrl>${apply_filter.value}</str:encodeUrl></c:if></c:forEach>&amp;f_l=${filter3.value}&amp;f_l=${filter2.value}&amp;f_l=${filter.value}&amp;f_l_l=3">${filter3.value}</a> (<fmt:formatNumber type="number" value="${filter3.count}"/>)
								<ul><c:forEach var="filter4" items="${filter3.locationFilters}" varStatus="status4">
									<c:if test="${status4.index <= 10}">
									<li style="display:none;"><a<c:if test="${model.filtered_location.equalsIgnoreCase(filter4.value)}"><c:set var="hideList" scope="session" value="false"/>  class="filtered"</c:if> href="${model.searchUrl}<c:forEach var="apply_filter" items="${model.filter_page}"><c:if test="${apply_filter.key != 'f_l'}">&amp;${apply_filter.key}=<str:encodeUrl>${apply_filter.value}</str:encodeUrl></c:if></c:forEach>&amp;f_l=${filter4.value}&amp;f_l=${filter3.value}&amp;f_l=${filter2.value}&amp;f_l=${filter.value}&amp;f_l_l=4">${filter4.value}</a> (<fmt:formatNumber type="number" value="${filter4.count}"/>)</li>
									</c:if>
								</c:forEach></ul>
							</li>
							</c:if>
						</c:forEach></ul>
					</li>
				</c:forEach>
				</ul></c:if>
				</li>
			</c:forEach>
			<li>
			</li>
		</ul>
	</div>
	
	<c:if test="${!empty model.type_filters}">
	<div class='filters'>
		<h4>Type</h4>
		<ul class="text-muted">
			<c:forEach var="filter" items="${model.type_filters}">
				<li><a href="${model.searchUrl}<c:forEach var="apply_filter" items="${model.filter_page}">&amp;${apply_filter.key}=<str:encodeUrl>${apply_filter.value}</str:encodeUrl></c:forEach>&amp;f_t=${filter.name}">${filter.name}</a> (<fmt:formatNumber type="number" value="${filter.count}"/>)</li>
			</c:forEach>
		</ul>
	</div>
	</c:if>

	<c:if test="${!empty model.rooms_filters}">
		<div class='filters'>
			<h4>Bedrooms</h4>
			<ul class="text-muted">
				<c:forEach var="filter" items="${model.rooms_filters}">
				<li><a href='javascript:bedroomFilter(${filter.name});'>${filter.name}</a>  (${filter.count}) </li>
				
<%-- 					<li><a
						href="${model.searchUrl}<c:forEach var="apply_filter" items="${model.filter_page}">&amp;${apply_filter.key}=<str:encodeUrl>${apply_filter.value}</str:encodeUrl></c:forEach>&amp;f_r=${filter.name}">${filter.name}</a>
						(<fmt:formatNumber type="number" value="${filter.count}" />)</li> --%>
				</c:forEach>
			</ul>
		</div>
	</c:if>
	<c:if test="${!model.grossarea_filter}">
		<div class='filters'>
			<h4>Gross Area (sqft)</h4>
			<input type="text" name="<%=Searcher.FILTER_GROSS_AREA_LOWER%>" size=4/> 
				<b> TO </b> 
			<input type="text" name="<%=Searcher.FILTER_GROSS_AREA_UPPER%>" size=4/>
			<input type="button" name="Filter" value="Add Filter" id="buttonFilter"/>
		</div>
	</c:if>
	<c:if test="${!model.saleablearea_filter}">
		<div class='filters'>
			<h4>Saleable Area (sqft)</h4>
			<input type="text" name="<%=Searcher.FILTER_SALEABLE_AREA_LOWER%>" size=4/> 
				<b> TO </b> 
			<input type="text" name="<%=Searcher.FILTER_SALEABLE_AREA_UPPER%>" size=4/>
			<input type="button" name="Add Filter" value="Add Filter" id="buttonFilterSaleable"/>
		</div>
	</c:if>
	<c:if test="${!empty model.posted_filters}">
	<div class='filters'>
		<h4>Last seen</h4>
		<ul class="text-muted">
			<c:forEach var="filter" items="${model.posted_filters}">
				<li><a href="${model.searchUrl}<c:forEach var="apply_filter" items="${model.filter_page}">&amp;${apply_filter.key}=<str:encodeUrl>${apply_filter.value}</str:encodeUrl></c:forEach>&amp;f_p=${filter.value}">${filter.name}</a> (<fmt:formatNumber type="number" value="${filter.count}"/>)</li>
			</c:forEach>
		</ul>
	</div>
	</c:if>
	
	<c:if test="${!empty model.agent_filters}">
	<div class='filters'>
		<h4>Real estate agent</h4>
		<ul class="text-muted">
			<c:forEach var="filter" items="${model.agent_filters}">
				<li><a href="${model.searchUrl}<c:forEach var="apply_filter" items="${model.filter_page}">&amp;${apply_filter.key}=<str:encodeUrl>${apply_filter.value}</str:encodeUrl></c:forEach>&amp;f_a=${filter.value}">${filter.name}</a> (<fmt:formatNumber type="number" value="${filter.count}"/>)</li>
			</c:forEach>
		</ul>
	</div>
	</c:if>
</div>