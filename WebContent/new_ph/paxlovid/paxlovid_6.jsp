<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>


<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="paxlovid_6" />
	<jsp:param name="block_header" value="Paxlovid" />
	<jsp:param name="topic_description" value="secondary_1" />
	<jsp:param name="topic_title" value="Dr. Visits" />
	<jsp:param name="did" value="55" />
	<jsp:param name="folder" value="paxlovid" />
	<jsp:param name="kpis" value="paxlovid/kpis_new.jsp" />

	<jsp:param name="simple_panel" value="paxlovid/pre_hosp.jsp" />

	<jsp:param name="datatable" value="paxlovid/viz_tables/demographics_table.jsp" />
	<jsp:param name="datatable_div" value="paxlovid_paxlovid_race" />
	<jsp:param name="datatable_kpis" value="first_diagnosis,reinfected" />
	<jsp:param name="datatable_feed" value="paxlovid/feeds/demographics.jsp" />
	
</jsp:include>
