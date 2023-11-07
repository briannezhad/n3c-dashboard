<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="totals" dataSource="jdbc/N3CPublic">
	select 
 		case
 			when sum(count) < 1000 then sum(count)::text
 			when sum(count) < 1000000 then to_char(sum(count)/1000.0, '999.99')||'k'
 			else to_char(sum(count)/1000000.0, '999.99')||'M'
 		end as count
			from (
				select max(total_patient) as count from n3c_dashboard_ph2.mh_all_patient_age_min_demographics_csd
			) as foo;
</sql:query>
	
<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
	<div class="col-12 kpi-main-col">
		<div class="panel-primary kpi">
			<div class="kpi-inner">
				<div class="panel-body">
					<table>
						<tr>
							<td>
								<span class="tip">
									<a class="viz_secondary_info" 
										title="<a class='close popover_close' data-dismiss='alert'>&times;</a> Total Patients with a Maternal Health-Related Condition in the Enclave" 
										data-html="true" data-toggle="popover" 
										data-placement="top" 
										data-content="
										<p>Total Number of Individuals within the Enclave who have had a maternal health-related condition 
										indicated in their EHR.</p>" aria-describedby="tooltip">
	 											<p style="margin-bottom:0px;">Total Patients w/Maternal Health-Related Conditions in Enclave <i class="fas fa-info-circle"></i>
	 											</p> 
 									</a>
 								</span>
 							</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-users"></i> <span id="${param.block}_all_environmental_patient_count_kpi">${row.count}</span></div>
			</div>
		</div>
	</div>
</c:forEach>
