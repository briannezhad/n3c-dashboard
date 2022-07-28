<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<div id="${param.block}_ethnicity_viz" class="col-12 dash_viz"></div>

<c:if test="${not empty param.symptom}">
<div id="${param.block}-long-ethnicity">
	<jsp:include page="../long_covid/long_before_static.jsp">
		<jsp:param name="block" value="${param.block}" />
		<jsp:param name="type" value="ethnicity" />
		<jsp:param name="symptom" value="${param.symptom}" />
	</jsp:include>
</div>
</c:if>

<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../long_covid/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>

<div id="${param.block}_ethnicity_save_viz"> 
	<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_ethnicity_viz', '${param.block}_ethnicity.svg');">Save as SVG</button>
	<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_ethnicity_viz', '${param.block}_ethnicity.png');">Save as PNG</button>
	<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_ethnicity_viz', '${param.block}_ethnicity.jpg');">Save as JPEG</button>
	<br><small>Note: Download will only include the top graph.</small>
</div>

<script>

var labeltest = '${param.label_width}';
var labelWidth = 150;

if (labeltest.length != 0){
	labelWidth = Number('${param.label_width}');
};


function ${param.block}_ethnicity_refresh() {
	var properties = {
			domName: '${param.block}_ethnicity_viz',
			barLabelWidth: labelWidth,
			legend_data: ethnicity_legend,
			secondary_range: ethnicity_range,
			legend_label: 'Ethnicity',
			min_height: 200,
			nofilter: 0,
			ordered: 1
		}

	// console.log("ethnicity graph", "${param.block}_ethnicity_viz", ${param.block}_ObservationEthnicityArray)
   	d3.select("#${param.block}_ethnicity_viz").select("svg").remove();
	localHorizontalStackedBarChart(${param.block}_ObservationEthnicityArray, properties);	
}

${param.block}_ethnicity_refresh();
</script>
