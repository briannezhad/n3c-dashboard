<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<c:choose>
	<c:when test="${param.type == 'operational' }">
		<sql:query var="projects" dataSource="jdbc/N3CPublic">
            	select
            		to_json(title) as title,
            		to_json(uid) as id,
            		to_json(research_statement) as research_statement,
            		to_json(lead_investigator) as lead_investigator,
            		to_json(accessing_institution) as accessing_institution,
            		task_team,
            		to_json(dur_project_id) as dur_project_id
            	from n3c_admin.enclave_project
            	where title ~ '\[N3C'
            	and lead_investigator != 'Mariam Deacy'
            	order by title::text;
         </sql:query>
	</c:when>
	<c:otherwise>
		<sql:query var="projects" dataSource="jdbc/N3CPublic">
            	select to_json(title) as title,
            		to_json(uid) as id,
            		to_json(research_statement) as research_statement,
            		to_json(lead_investigator) as lead_investigator,
            		to_json(accessing_institution) as accessing_institution,
            		task_team,
            		to_json(dur_project_id) as dur_project_id
            	from n3c_admin.enclave_project
            	where title !~ '\[N3C'
            	and lead_investigator != 'Mariam Deacy'
            	order by title::text;
         </sql:query>
	</c:otherwise>
</c:choose>
			
{
    "headers": [
     	{"value":"task_team", "label":"Task Team?"},
        {"value":"title", "label":"Title"},
        {"value":"description", "label":"Research Statement"},
        {"value":"pi_name", "label":"Lead Investigator"},
        {"value":"accessing_institution", "label":"Accessing Institution"},
        {"value":"id", "label":"ID"},
        {"value":"dur_project_id", "label":"DUR"}  
    ],
    "rows" : [
    <c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	    {	"task_team":"${row.task_team}",
	    	"title":${row.title},
	    	"description":${row.research_statement},
	    	"pi_name":${row.lead_investigator},
	    	"accessing_institution":${row.accessing_institution},
	    	"id":${row.id},
	    	"dur_project_id":${row.dur_project_id}
	    }<c:if test="${!rowCounter.last}">,</c:if>
</c:forEach>
    ]
}