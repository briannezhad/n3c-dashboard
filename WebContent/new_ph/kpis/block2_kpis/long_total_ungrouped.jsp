<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

 <sql:query var="totals" dataSource="jdbc/N3CPublic">
 	select 
 		case
 			when sum(count) < 1000 then sum(count)::text
 			when sum(count) < 1000000 then to_char(sum(count)/1000.0, '999.99')||'k'
 			else to_char(sum(count)/1000000.0, '999.99')||'M'
 		end as patient_count
 	from (select 
			case
				when (count = '<20' or count is null) then 0
				else count::int
			end as count
			from n3c_questions.icd10_individual_symptom_summary_counts_by_symptom
			<c:if test="${not empty param.symptom}">where symptom = '${param.symptom}' and observation != 'Does not have U09.9 in Record'</c:if>
		) as foo
</sql:query>
<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
	<div class="col-12 col-md-3 kpi-main-col">
		<div class="panel-primary kpi">
			<div class="kpi-inner">
				<div class="panel-body">
					<table>
						<tr>
							<td><i class="fas fa-users"></i> COVID+ Patients That Tested Positive</td>
						</tr>
					</table>
				</div>
				<div id="${param.block}_patient_count_kpi" class="panel-heading kpi_num">${row.patient_count}</div>
				<div class="kpi-limit"><small>(see limitations below)</small></div>
			</div>
		</div>
	</div>
</c:forEach>
