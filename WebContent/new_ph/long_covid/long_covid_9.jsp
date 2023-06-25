<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="long_covid_9" />
	<jsp:param name="block_header" value="Long COVID: Mental Health Condition" />
	<jsp:param name="topic_description" value="secondary_9" />
	<jsp:param name="topic_title" value="Counts of Patients Who Have Experienced Mental Health Conditions by COVID-19/Long COVID Status" />
	<jsp:param name="topic_title2" value="Counts of Patients Who Have Experienced Mental Health Conditions Before and After COVID-19 Diagnosis" />
	<jsp:param name="folder" value="long_covid" />
	<jsp:param name="did" value="${param.did}" />
	
	<jsp:param name="kpis" value="long_covid/kpis.jsp" />
	<jsp:param name="kpi_filter" value="Mental Health Condition" />

	<jsp:param name="age_filter4" value="true" />
	<jsp:param name="race_filter" value="true" />
	<jsp:param name="sex_filter" value="true" />
	<jsp:param name="ethnicity_filter" value="true" />
	
	<jsp:param name="symptom" value="Mental%20Health%20Condition" />

	<jsp:param name="simple_panel" value="long_covid/observation.jsp" />
	<jsp:param name="labelwidth" value="210" />

	<jsp:param name="datatable" value="long_covid/tables/symptom_mental_table.jsp" />
	<jsp:param name="datatable_div" value="long_covid_symptom_mental" />
	<jsp:param name="datatable_feed" value="long_covid/feeds/symptom_ungrouped.jsp?symptom=Mental+Health+Condition" />
	<jsp:param name="datatable_filtered_kpis" value="observation|Tested positive|tested_positive|patient_count,observation|Has U09.9 in Record|in_record|patient_count" />
	<jsp:param name="datatable_kpis2" value="long_individual" />
</jsp:include>
