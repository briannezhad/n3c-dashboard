<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	SELECT jsonb_pretty(jsonb_agg(done.*)) AS jsonb_pretty
   FROM ( SELECT severity_abbrev as severity,
            gender_map3.gender_abbrev AS sex,
            age_map6.age_abbrev AS age_bin,
            foo.race,
            foo.comorbidities,
            foo.patient_display,
            foo.patient_count,
            age_map6.age_abbrev,
            age_map6.age_seq,
            race_map.race_abbrev,
            race_map.race_seq,
            gender_map3.gender_abbrev as sex_abbrev,
            gender_map3.gender_seq as sex_seq,
            severity_map.severity_abbrev,
            severity_map.severity_seq
           FROM ( SELECT covid_positive_comorbidities_demo_censored_wo_vax_adult_ped_.severity_type AS severity,
                    COALESCE(covid_positive_comorbidities_demo_censored_wo_vax_adult_ped_.gender_concept_name, 'null'::text) AS gender,
                    COALESCE(covid_positive_comorbidities_demo_censored_wo_vax_adult_ped_.age_bin, 'null'::text) AS age_bin,
                    covid_positive_comorbidities_demo_censored_wo_vax_adult_ped_.race_concept_name AS race,
                    regexp_replace(covid_positive_comorbidities_demo_censored_wo_vax_adult_ped_.comorbidity_list, 'Charlson - '::text, ''::text, 'g'::text) AS comorbidities,
                    covid_positive_comorbidities_demo_censored_wo_vax_adult_ped_.num_patients AS patient_display,
                        CASE
                            WHEN covid_positive_comorbidities_demo_censored_wo_vax_adult_ped_.num_patients = '<20'::text OR covid_positive_comorbidities_demo_censored_wo_vax_adult_ped_.num_patients IS NULL THEN 0
                            ELSE covid_positive_comorbidities_demo_censored_wo_vax_adult_ped_.num_patients::integer
                        END AS patient_count
                   FROM n3c_questions_new.covid_positive_comorbidities_demo_censored_wo_vax_adult_ped_
                  WHERE covid_positive_comorbidities_demo_censored_wo_vax_adult_ped_.num_patients IS NOT NULL 
                  AND covid_positive_comorbidities_demo_censored_wo_vax_adult_ped_.num_patients <> '<20'::text ) foo
             JOIN n3c_dashboard.age_map6 USING (age_bin)
             JOIN n3c_dashboard.race_map USING (race)
             JOIN n3c_dashboard.gender_map3 USING (gender)
             JOIN n3c_dashboard.severity_map USING (severity)
             ) done;
             
</sql:query>
{
    "headers": [
        {"value":"severity", "label":"Severity"},
        {"value":"sex", "label":"Sex"},
        {"value":"age_bin", "label":"Age"},
        {"value":"race", "label":"Race"},
        {"value":"comorbidities", "label":"Comorbidities"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"age_abbrev", "label":"dummy1"},
        {"value":"age_seq", "label":"dummy2"},
        {"value":"race_abbrev", "label":"dummy3"},
        {"value":"race_seq", "label":"dummy4"},
        {"value":"sex_abbrev", "label":"dummy7"},
        {"value":"sex_seq", "label":"dummy8"},
        {"value":"severity_abbrev", "label":"dummy9"},
        {"value":"severity_seq", "label":"dummy0"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}