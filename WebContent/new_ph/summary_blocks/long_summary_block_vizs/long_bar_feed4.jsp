<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="ages" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select sum(
		case
		when (count = '<20' or count is null) then 0
		else count::int
		end) as count,
		observation as label, 
		case
		when (observation = 'Tested positive') then 3
		when (observation = 'Does not have U09.9 in Record') then 3
		when (observation = 'Has not tested positive') then 12
		when (observation = 'Has U09.9 in Record') then 3
		end as viz_id
		from n3c_questions_new.icd10_individual_symptom_summary_counts_long_covid 
		where observation != 'Does not have U09.9 in Record'
		group by observation
		order by count
	) as done;
</sql:query>
{"rows": 
<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}







