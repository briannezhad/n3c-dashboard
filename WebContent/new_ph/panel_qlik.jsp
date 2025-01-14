<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<style>
	iframe{
		/* SVGs generated at https://icons8.com/preloaders/en/circular# */
		background:url(<util:applicationRoot/>/images/spinners/fading_wheel.svg) no-repeat center 100px;
		/* to resize, use background-size: 300px 300px; */
	}
	​
</style>
<sql:query var="roster" dataSource="jdbc/N3CPublic">
	select iframe_content from n3c_questions_new.roster where iframe_info = ? ;
	<sql:param>${param.iframe}</sql:param>
</sql:query>
<c:forEach items="${roster.rows}" var="row" varStatus="rowCounter">
	<c:set var="iframe_content" value="${row.iframe_content}" />
</c:forEach>

<div id="question-tile">
	<div id="question-tile-iframe">
	</div>
</div>

<script>
	(async() => {
		$("body").css("cursor", "wait");
		
		const { config, csrfTokenInfo } = await auth2();
		
		// console.log("iframe", "${param.iframe}", "content", "${iframe_content}");
		// console.log(csrfTokenInfo);
		
		$("body").css("cursor", "default");

		cache_browser_history("public-health", "public-health/${param.iframe}");

		document.getElementById("question-tile-iframe").removeAttribute("style");
		iframe_render(
			config.tenantDomain,
			config.appId,
			'${iframe_content}',
			config.qlikWebIntegrationId,
			csrfTokenInfo.headers.get("qlik-csrf-token"),
			'border:none;width:100%;height:1200px;", "iframe_content": "${iframe_content}',
			"${param.iframe}"
		);
	})();


function iframe_render(tenant, appID, content, integrationID, token, style, iframe) {
	var divContainer = document.getElementById("question-tile-iframe");
	// console.log("iframe", iframe)
	cache_browser_history("public-health", "public-health/${param.iframe}");
		divContainer.innerHTML = 
			'<div id="d3viz"></div>'
			+'<iframe src="https://'+tenant+'/single/?appid='+appID+'&sheet='+content
			+'&qlik-web-integration-id='+integrationID
			+'&qlik-csrf-token='+token+'" style="'+style+'" ></iframe>'
		;
}

</script>