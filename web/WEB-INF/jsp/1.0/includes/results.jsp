<%@ include file="include.jsp" %>
<div id="results" class="col-sm-9 col-md-9 col-lg-6">
	<jsp:include page="results_info.jsp"></jsp:include>
		<!-- <div class="fadeMe"></div> -->
	<c:forEach var="result" items="${model.results}">
		<div class="property">
			<div class="row">
				<div class="col-sm-9 col-md-9 title"><h2><a target="_blank" href="${result.propertyDetailsUrl}">${result.title}</a></h2></div>
				<div class="col-sm-3 col-md-3 price">
					<h2>&#163;<fmt:formatNumber maxFractionDigits="0" value="${result.monthlyRental}"/></h2>
				</div>				
			</div>
			<div class="row">
				<div class="col-sm-12 col-md-12 col-lg-12">
<%-- 					<c:if test="${!empty result.agent}"><span>${result.agent} - </span></c:if>
					<c:if test="${!empty result.street}"><span>${result.street},</span></c:if>   --%>
					<span class="location"><c:forEach var="location" items="${result.locality}" varStatus="status">
					<c:if test="${status.index > 0}">, </c:if>${location}</c:forEach></span>
					<div class="address">
						${result.address}
					</div>
				</div>
			</div>
			<div class="row">
 			
 				<div class="col-sm-3 col-md-3 photo">
					<div class="prop-img">
						<div class="photo-frame">
						<%-- <img src="<c:url value="/assets/propimages/sample2.jpeg"/>"/> --%>
						
							<img src="${result.thumbnailPath}">
						</div>
					</div>
				</div>
<%-- 				<div<c:if test="${!empty result.image}"> class="col-sm-9 col-md-9 col-lg-9 other"</c:if>
				<c:if test="${empty result.image}"> class="col-sm-12 col-md-12 col-lg-12 other"</c:if>> --%>
					<div class="col-sm-4 col-md-4">
						<div class="rooms">${result.bedRooms}</div>
						</div>						
					</div>
					<div class="row">
						<div name="saleableArea"> 
							<c:if test="${result.saleableArea > 0}">
							Saleable Area:
								${result.saleableArea} ${result.unit}
							</c:if>
						</div>
						<div name="grossArea"> 
							<c:if test="${result.grossArea > 0}">
							Gross Area:
								${result.grossArea} ${result.unit}
							</c:if>
						</div>
					</div>						
				</div>
			<div class="row">
					<div class="description">${result.summary}</div>
					<div class="row more-options">
						<div class="col-sm-8 col-md-8 photo">
							<a target="_blank" href="${result.propertyDetailsUrl}">full details and photos &raquo;</a>
						</div>
			</div>
										
				</div>
			</div>			
		</div>
	</c:forEach>
	
	<jsp:include page="pagination.jsp"></jsp:include>
</div>