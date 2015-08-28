<%@ include file="include.jsp" %>
	<div class="row results_info hidden-xs" id="result-bar">
		<div class="col-sm-6 col-md-6" id="result-info">
			Results ${model.start}-${model.end} of <fmt:formatNumber maxFractionDigits="0" value="${model.total}"/>
		</div>
		<div class="col-sm-6 col-md-6" id="sort">
			<div class="form-inline">Sort by 
				<select id="sort" name="s" class="input-sm form-control">
					<option value="r"<c:if test="${model.sort == 'r'}"> selected="selected"</c:if>>Most relevant</option>
					<%-- <option value="d"<c:if test="${model.sort == 'd'}"> selected="selected"</c:if>>Most recent</option> --%>
					<option value="h"<c:if test="${model.sort == 'h'}"> selected="selected"</c:if>>Price (highest to lowest)</option>
					<option value="l"<c:if test="${model.sort == 'l'}"> selected="selected"</c:if>>Price (lowest to highest)</option>
				</select></div>
		</div>
	</div>