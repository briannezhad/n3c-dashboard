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
			from (select
					case
						when (patient_count::text = '<20' or patient_count::text is null) then 0
						else patient_count::int
					end as count
				  from n3c_dashboard_ph.env_envsxmortvac_all_csd
				  where long_covid_diagnosis_post_covid_indicator = 1
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
										title="<a class='close popover_close' data-dismiss='alert'>&times;</a> Total Long COVID Patients in View" 
										data-html="true" data-toggle="popover" 
										data-placement="top" 
										data-content="<p><strong>Long COVID Defined As:</strong> any patient having the ICD-10 code for PASC (U09.9) within their EHR.</p>
										<small class='kpi-small-note'>The ICD-10 for PASC (U09.9) was not created until October 1, 2021, and any data using this code will be 
										limited to after this date. This count is out of current total patients in view.</small>
										<br>" aria-describedby="tooltip">
	 											<p style="margin-bottom:0px;">Long COVID in View* <i class="fas fa-info-circle"></i>
	  											<span class="sr-only">, or any patient having the ICD-10 code for PASC (U09.9) within their EHR.
	  											</span>
	 											</p> 
 									</a>
 								</span>
 							</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-user-clock"></i> <span id="${param.block}_long_covid_patient_count_kpi">${row.count}</span></div>
			</div>
		</div>
	</div>

</c:forEach>
