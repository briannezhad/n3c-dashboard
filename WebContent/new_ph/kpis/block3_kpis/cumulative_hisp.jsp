<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="totals" dataSource="jdbc/N3CPublic">
 	select 
 		case
 			when count_hispanic < 1000 then count_hispanic::text
 			when count_hispanic < 1000000 then to_char(count_hispanic/1000.0, '999.99')||'k'
 			else to_char(count_hispanic/1000000.0, '999.99')||'M'
 		end as count from (
    	select
    	sum(case when (count_hispanic = '<20') then 0 else COALESCE(count_hispanic::int, 0) end) as count_hispanic
    	from n3c_dashboard_ph.demoirb_demo_csd
	) as foo;
</sql:query>
<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
	<div class="col-12 kpi-main-col">
		<div class="panel-primary kpi">
			<div class="kpi-inner">
				<div class="panel-body">
					<table>
						<tr>
							<td>Total Hispanic Patients</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-users"></i> <span id="${param.block}_count_hispanic_kpi">${row.count}</span></div>
			</div>
		</div>
	</div>
</c:forEach>
