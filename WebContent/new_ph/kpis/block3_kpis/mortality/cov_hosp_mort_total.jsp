<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="totals" dataSource="jdbc/N3CPublic">
 	select 
 		case
 			when sum(patient_count) < 1000 then sum(patient_count)::text
 			when sum(patient_count) < 1000000 then to_char(sum(patient_count)/1000.0, '999.99')||'k'
 			else to_char(sum(patient_count)/1000000.0, '999.99')||'M'
 		end as count
			from (select
					max(total_patients) as patient_count
					from n3c_dashboard_ph.mor_icd10demogrouped_csd
				) as foo;
</sql:query>
<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
	<div class="col-12 kpi-main-col">
		<div class="panel-primary kpi">
			<div class="kpi-inner">
				<div class="panel-body">
					<table>
						<tr>
							<td>Total Mortalities after COVID-Related Hospitalization*</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-users"></i> <span id="${param.block}_mortality_kpi">${row.count}</span></div>
			</div>
		</div>
	</div>
</c:forEach>
