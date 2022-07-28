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
var labeltest = '${param.label_width}';
var labelWidth = 150;

if (labeltest.length != 0){
	labelWidth = Number('${param.label_width}');
};

function ${param.block}_race_refresh() {
	var properties = {
			domName: '${param.block}_race_viz',
			barLabelWidth: labelWidth,
			legend_data: race_legend,
			secondary_range: race_range,
			legend_label: 'Race',
			min_height: "${param.viz_height}",
			nofilter: 0,
			ordered: 1
		}

	console.log("race graph", "${param.block}_race_viz", ${param.block}_SymptomRaceArray)
   	d3.select("#${param.block}_race_viz").select("svg").remove();
	localHorizontalStackedBarChart(${param.block}_SymptomRaceArray, properties);	
}

${param.block}_race_refresh();
</script>
