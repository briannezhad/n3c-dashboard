<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<div id="${param.block}_beforeafter_viz" class="col-12 dash_viz"></div>

<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../long_covid/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>

<div id="${param.block}_beforeafter_save_viz"> 
	<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_beforeafter_viz', '${param.block}_beforeafter.svg');">Save as SVG</button>
	<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_beforeafter_viz', '${param.block}_beforeafter.png');">Save as PNG</button>
	<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_beforeafter_viz', '${param.block}_beforeafter.jpg');">Save as JPEG</button>
</div>

<script>

function ${param.block}_before_refresh() {
	var properties = {
			domName: '${param.block}_beforeafter_viz',
			barLabelWidth: 160,
			legend_data: before_after_legend,
			secondary_range: categorical,
			legend_label: 'Symptom Occurrence',
			min_height: 200,
			nofilter: 0,
			ordered: 1
		}

   	d3.select("#${param.block}_beforeafter_viz").select("svg").remove();
	localHorizontalStackedBarChart(${param.block}_BeforeAfterArray, properties);	
}

${param.block}_before_refresh();
</script>
