<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="${param.block}symptomoccurrence_accordion">
 		<div class="card">
 			<div class="card-header" id="${param.block}symptomoccurrence_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#${param.block}symptomoccurrence_body" aria-expanded="true" aria-controls="${param.block}symptomoccurrence_body">
  					Condition Relative to COVID+
 				</button>
				</h2>
			</div>
		</div>
		<div id="${param.block}symptomoccurrence_body" class="collapse" aria-labelledby="${param.block}symptomoccurrence_heading" data-parent="#${param.block}symptomoccurrence_accordion">
			<div class="card-body">
				<div id="${param.block}symptomoccurrence_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('${param.block}symptomoccurrence_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('${param.block}symptomoccurrence_panel');">None</button><br>
					<select id="${param.block}-symptomoccurrence-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select condition_after_covid_positive as condition from n3c_dashboard.before_after_map order by condition_after_covid_positive_seq;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.condition}">${row.condition}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
