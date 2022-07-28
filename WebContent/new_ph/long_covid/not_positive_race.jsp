<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<div id="${param.block}_race_viz" class="col-12 dash_viz"></div>

<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../long_covid/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>

<div id="${param.block}_race_save_viz"> 
	<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_race_viz', '${param.block}_race.svg');">Save as SVG</button>
	<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_race_viz', '${param.block}_race.png');">Save as PNG</button>
	<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_race_viz', '${param.block}_race.jpg');">Save as JPEG</button>
</div>

<script>

function ${param.block}_race_refresh() {
	var properties = {
			domName: '#${param.block}_race_viz',
			barLabelWidth: 70,
			min_height: 300,
			ordered: 0,
			colorscale: race_range
	}

	// console.log("race graph", "${param.block}_gender_viz", ${param.block}_RaceArray)
	d3.select("#${param.block}_race_viz").select("svg").remove();
	localHorizontalBarChart(${param.block}_RaceArray, properties);
}

${param.block}_race_refresh();

</script>
