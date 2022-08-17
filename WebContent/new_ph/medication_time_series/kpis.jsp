<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../kpis/block2_kpis/covid_positive.jsp">
	<jsp:param name="block" value="${param.block}" />
</jsp:include>
<jsp:include page="../kpis/block2_kpis/medication_ts_patients.jsp">
	<jsp:param name="block" value="${param.block}" />
</jsp:include>
<c:if test="${param.block == 'medication_ts_1' }">
	<jsp:include page="../kpis/block2_kpis/medication_ts_selected.jsp">
		<jsp:param name="block" value="${param.block}" />
	</jsp:include>
</c:if>