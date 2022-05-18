<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<div id="${param.block}_ethnicity_viz" class="col-12 dash_viz"></div>
<div id="${param.block}_ethnicity_save_viz"> 
	<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_ethnicity_viz', '${param.block}_ethnicity.svg');">Save as SVG</button>
	<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_ethnicity_viz', '${param.block}_ethnicity.png');">Save as PNG</button>
	<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_ethnicity_viz', '${param.block}_ethnicity.jpg');">Save as JPEG</button>
</div>

<script>

var labeltest = '${param.label_width}';
var labelWidth = 150;

if (labeltest.length != 0){
	labelWidth = Number('${param.label_width}');
};

function ${param.block}_ethnicity_refresh() {
	console.log("ethnicity graph", "${param.block}_ethnicity_viz", ${param.block}_SymptomEthnicityArray)
   	d3.select("#${param.block}_ethnicity_viz").select("svg").remove();
	localHorizontalStackedBarChart(${param.block}_SymptomEthnicityArray,"${param.block}_ethnicity_viz", labelWidth, ethnicity_legend, ethnicity_range, "Ethnicity" ,"${param.viz_height}");	
}

${param.block}_ethnicity_refresh();
</script>
