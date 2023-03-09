<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="viz_options_dropdown">
	<span class="align-middle">Explore Topic By </span>
	<select id="${param.block}toggle_viz_select">
		<option value="severity">Severity</option>
		<option value="sex">Sex</option>
		<option hidden value="verylongtextverylongtext">verylongtextverylongtext</option>
	</select>
</div>

<div class="row" id="${param.block}viz1">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title} by Severity and Sex</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_severity_viz', '${param.topic_title} by Severity and Sex.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_severity_viz', '${param.topic_title} by Severity and Sex.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_severity_viz', '${param.topic_title} by Severity and Sex.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_severity_viz" class="col-12 dash_viz"></div>
	</div>
</div>

<div class="row" id="${param.block}viz2" style="display:none;">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title} by Sex and Severity</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sex_viz', '${param.topic_title} by Sex and Severity.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sex_viz', '${param.topic_title} by Sex and Severity.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sex_viz', '${param.topic_title} by Sex and Severity.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_sex_viz" class="col-12 dash_viz"></div>
	</div>
</div>
				

<script>

$('#${param.block}toggle_viz_select').select2({
	minimumResultsForSearch: Infinity,
	templateResult: function(option) {
	      if(option.element && (option.element).hasAttribute('hidden')){
	         return null;
	      }
	      return option.text;
	   }
});

$('#${param.block}toggle_viz_select').change(function () {
	var viz = $(this).val();
	
	if (viz == "severity"){
		$('#${param.block}viz2').css('display', 'none');
		$('#${param.block}viz1').css('display', 'block');
		${param.block}_severity_refresh();
	};
	if (viz == "sex"){
		$('#${param.block}viz1').css('display', 'none');
		$('#${param.block}viz2').css('display', 'block');
		${param.block}_sex_refresh();
	};
});

function ${param.block}_severity_refresh() {
	var properties = {
			domName: '${param.block}_severity_viz',
			barLabelWidth: 120,
			legend_data: sex_legend,
			secondary_range: sex_range,
			legend_label: 'Sex'
		}
   	d3.select("#${param.block}_severity_viz").select("svg").remove();
	localHorizontalStackedBarChart(${param.block}_SeveritySexArray, properties);	
}

${param.block}_severity_refresh();

function ${param.block}_sex_refresh() {
	var properties = {
			domName: '${param.block}_sex_viz',
			barLabelWidth: 120,
			legend_data: severity_legend,
			secondary_range: severity_range,
			legend_label: 'Severity'
		}
   	d3.select("#${param.block}_sex_viz").select("svg").remove();
	localHorizontalStackedBarChart(${param.block}_SexSeverityArray, properties);	
}

${param.block}_sex_refresh();
</script>
