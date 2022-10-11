<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select age_bin as age, gender_abbrev as gender, race, ethnicity, observation, 
				CASE
						when (symptom = 'Cognitive impairment') then 'Cognitive Impairment (CI)'
						when (symptom = 'Shortness of breath') then 'Shortness of Breath (SOB)'
						when (symptom = 'Mental Health Condition') then 'Mental Health Condition (MHC)'
						when (symptom = 'Fatigue') then 'Fatigue'
						when (symptom = 'POTS') then 'POTS'
						else replace(replace(replace(symptom, 'Cognitive impairment', 'CI'), 'Shortness of breath', 'SOB'), 'Mental Health Condition', 'MHC')
					end as symptom,
				symptom as symptom_long,
				patient_display, patient_count,
				 age_abbrev, age_seq, race_abbrev, race_seq, ethnicity_abbrev, ethnicity_seq, gender_abbrev, gender_seq,
				 observation_seq, symptom_seq
			from (select
					coalesce(age_bin, 'Unknown') as age_bin,
					coalesce(gender_concept_name, 'Unknown') as gender,
					coalesce(race_concept_name, 'Missing/Unknown') as race,
					coalesce(ethnicity_concept_name, 'Missing/Unknown') as ethnicity,
					observation,
					symptom,
					count as patient_display,
					symptom_seq,
					case
						when (count = '<20' or count is null) then 0
						else count::int
					end as patient_count
				  from n3c_questions_new.icd10_individual_symptom_summary_counts_long_covid
				  natural join n3c_dashboard.symptom_grouped_map
				  WHERE count IS NOT NULL and count != '<20'
		  	) as foo
		  	natural join n3c_dashboard.age_map4
		  	natural join n3c_dashboard.gender_map2
		  	natural join n3c_dashboard.race_map
		  	natural join n3c_dashboard.ethnicity_map
		  	natural join n3c_dashboard.observation_map
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"age", "label":"Age"},
        {"value":"gender", "label":"Gender"},
        {"value":"race", "label":"Race"},
        {"value":"ethnicity", "label":"Ethnicity"},
        {"value":"observation", "label":"Observation"},
        {"value":"symptom", "label":"Symptom Short"},
        {"value":"symptom_long", "label":"Symptom"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"age_abbrev", "label":"dummy1"},
        {"value":"age_seq", "label":"dummy2"},
        {"value":"race_abbrev", "label":"dummy3"},
        {"value":"race_seq", "label":"dummy4"},
        {"value":"ethnicity_abbrev", "label":"dummy5"},
        {"value":"ethnicity_seq", "label":"dummy6"},
        {"value":"gender_abbrev", "label":"dummy7"},
        {"value":"gender_seq", "label":"dummy8"},
        {"value":"observation_seq", "label":"dummy9"},
        {"value":"symptom_seq", "label":"dummy10"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
