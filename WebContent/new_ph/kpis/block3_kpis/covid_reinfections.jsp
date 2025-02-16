<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

 <sql:query var="totals" dataSource="jdbc/N3CPublic">
 	select to_char(sum(first_diagnosis)/1000000.0, '999.99')||'M' as first_diagnosis, to_char(sum(reinfected)/1000.0, '999.99')||'k' as reinfected
 	from (select 
 			case
				when (first_diagnosis_count = '<20' or first_diagnosis_count is null) then 0
				else first_diagnosis_count::int
			end as first_diagnosis,
			case
				when (original_infection_date_for_reinfected_count = '<20' or original_infection_date_for_reinfected_count is null) then 0
				else original_infection_date_for_reinfected_count::int
			end as reinfected
			from n3c_dashboard_ph.rein_covdatecounts_csd) as foo
</sql:query>
<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
	<div class="col-12 kpi-main-col">
		<div class="panel-primary kpi">
			<div class="kpi-inner">
				<div class="panel-body">
					<table>
						<tr>
							<td>Reinfection Count*</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-users"></i> <span id="${param.block}_reinfected_kpi">${row.reinfected}</span></div>
			</div>
		</div>
	</div>
</c:forEach>