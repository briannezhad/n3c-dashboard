<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="totals" dataSource="jdbc/N3CPublic">
	select to_char(value::int/1000000.0, '999.99')||'M' as count from n3c_admin.enclave_stats where title='person_rows';
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
										title="<a class='close popover_close' data-dismiss='alert'>&times;</a> Total Patients in the N3C Data Enclave" 
										data-html="true" data-toggle="popover" 
										data-placement="top" 
										data-content="<p>Total Number of Individual Persons within the N3C Data Enclave</p>" aria-describedby="tooltip">
	 											<p style="margin-bottom:0px;">Total Patients in Enclave <i class="fas fa-info-circle"></i>
	 											</p> 
 									</a>
 								</span>
 							</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-users"></i> ${row.count}</div>
			</div>
		</div>
	</div>
	<sql:query var="totals" dataSource="jdbc/N3CPublic">
		select split_part(substring(value, '-(.+)'), '-', 1) as release,  to_char(TO_DATE(substring(value, '[\w]*-[\w]*-(.*)'), 'YYYY/MM/DD'), 'Mon DD, YYYY') as date from n3c_admin.enclave_stats where title='release_name';
	</sql:query>
	<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
		<p class="data-as-of"><em>Data as of ${row.date} (${row.release})</em></p>
	</c:forEach>
	<div class="kpi-limit"><a onclick="${param.block}limitlink(); return false;" href="#${param.block}limitations-section">* See Limitations Below</a></div>
</c:forEach>

<script>
//popover stuff
$(function () {
	$('[data-toggle="popover"]').popover()
});
$(document).on("click", ".popover .close" , function(){
    $(this).parents(".popover").popover('hide');
});
</script>