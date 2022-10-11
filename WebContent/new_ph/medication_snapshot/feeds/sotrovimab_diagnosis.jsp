<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select diagnosis, severity_abbrev as severity, patient_display, patient_count,
				severity_abbrev, severity_seq, diagnosis_abbrev, diagnosis_seq as diagnosis_seq
			from (select
					severity_type as severity,
					covid_event_type as diagnosis_type,
					count as patient_display,
					case
						when (count = '<20' or count is null) then 0
						else count::int
					end as patient_count
				  from n3c_questions_new.sotrovimab_test_type
		  	) as foo
		  	natural join n3c_dashboard.severity_map
		  	left join n3c_dashboard.diagnosis_map on foo.diagnosis_type =  n3c_dashboard.diagnosis_map.diagnosis
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"diagnosis", "label":"Diagnosis Type"},
        {"value":"severity", "label":"Severity"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"severity_abbrev", "label":"dummy1"},
        {"value":"severity_seq", "label":"dummy2"},
        {"value":"diagnosis_abbrev", "label":"dummy3"},
        {"value":"diagnosis_seq", "label":"dummy4"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}