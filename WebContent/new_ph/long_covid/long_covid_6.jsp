<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="long_covid_6" />
	<jsp:param name="block_header" value="Long COVID: ICD-10 Symptom Counts Before/After COVID+" />
	<jsp:param name="topic_description" value="secondary_6" />
	<jsp:param name="topic_title" value="When Patients Experienced Long COVID-Related Symptoms (Before or After COVID Diagnosis)" />
	<jsp:param name="folder" value="long_covid" />
	<jsp:param name="did" value="${param.did}" />

	<jsp:param name="kpis" value="long_covid/kpis.jsp" />

	<jsp:param name="simple_panel" value="long_covid/beforeAfter.jsp" />
	
	<jsp:param name="beforeafter_filter" value="true" />

	<jsp:param name="datatable" value="long_covid/tables/before_after_table.jsp" />
	<jsp:param name="datatable_div" value="long_covid_before_after" />
	<jsp:param name="datatable_feed" value="long_covid/feeds/before_after.jsp" />
	
	<jsp:param name="BeforeAfterArray" value="true" />
</jsp:include>
