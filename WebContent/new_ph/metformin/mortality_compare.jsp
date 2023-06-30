<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<div class="row">
	<div class="col-12 col-md-6">
		<div class="row">
			<div class="col-12 viz-header-section">
				<h2 id="mortality-title1" class="viz-title"></h2>
				<div class="btn-group float-right">
					<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-download"></i>
					</button>
					<div class="dropdown-menu dropdown-menu-right">
						<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality1('.jpg');">Save as JPG</a>
						<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality1('.png');">Save as PNG</a>
						<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality1('.svg');">Save as SVG</a>
					</div>
				</div>
			</div>
			<div class="col-12">
				<div id="${param.block}_mortality1_viz" class="dash_viz"></div>
			</div>
		</div>
	</div>
	<div class="col-12 col-md-6">
		<div class="row">
			<div class="col-12 viz-header-section">
				<h2 id="mortality-title2" class="viz-title"></h2>
				<div class="btn-group float-right">
					<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-download"></i>
					</button>
					<div class="dropdown-menu dropdown-menu-right">
						<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality2('.jpg');">Save as JPG</a>
						<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality2('.png');">Save as PNG</a>
						<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality2('.svg');">Save as SVG</a>
					</div>
				</div>
			</div>
			<div class="col-12">
				<div id="${param.block}_mortality2_viz" class="dash_viz"></div>
			</div>
		</div>
	</div>
</div>


<script>
//this is to change the title of the download based on which visualization mode is selected
function ${param.block}save_viz_pass_mortality1(extension){
	
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode =='pie'){		
		text = "Mortality Percentages of ${param.topic_title} Prescribed Metformin" + extension;
	} else if (mode == 'bar'){
		text = "Counts of ${param.topic_title} Prescribed Metformin by Mortality" + extension;
	} else {
		text = "Mortality Percentages of ${param.topic_title}  Prescribed Metformin" + extension;
	};
	
	saveVisualization('${param.block}_mortality1_viz', text);
};

function ${param.block}save_viz_pass_mortality2(extension){
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode =='pie'){		
		text = "Mortality Percentages of ${param.topic_title} Not Prescribed Metformin" + extension;
	} else if (mode == 'bar'){
		text = "Counts of ${param.topic_title} Not Prescribed Metformin by Mortality" + extension;
	} else {
		text = "Mortality Percentages of ${param.topic_title} Not Prescribed Metformin" + extension;
	};
	
	saveVisualization('${param.block}_mortality2_viz', text);
};

// set inital title based on load mode
var title_id = $("#${param.block}-mode").find('.text-primary').attr('id');
var title_strings = title_id.split('-');
var title_mode = title_strings[title_strings.length-1];

if (title_mode =='pie'){		
	var title = "Mortality Percentages of ${param.topic_title} who were Prescribed Metformin";
	$("#mortality-title1").text(title);
} else if (title_mode == 'bar'){
	var title = "Counts of ${param.topic_title} who were Prescribed Metformin by Mortality";
	$("#mortality-title1").text(title);
} else {
	var title = "Mortality Percentages of ${param.topic_title} who were Prescribed Metformin";
	$("#mortality-title1").text(title);
};

//this is to change the title of the graphic based on which visualization mode is selected
$('#${param.block}-mode-barpercent').on('mouseup', function() {
	var title = "Mortality Percentages of ${param.topic_title} who were Prescribed Metformin";
	$("#mortality-title1").text(title);
});
$('#${param.block}-mode-bar').on('mouseup', function() {
	var title = "Counts of ${param.topic_title} who were Prescribed Metformin by Mortality";
	$("#mortality-title1").text(title);
});
$('#${param.block}-mode-pie').on('mouseup', function() {
	var title = "Mortality Percentages of ${param.topic_title} who were Prescribed Metformin";
	$("#mortality-title1").text(title);
});

//set inital title based on load mode
var title_id2 = $("#${param.block}-mode").find('.text-primary').attr('id');
var title_strings = title_id.split('-');
var title_mode = title_strings[title_strings.length-1];

if (title_mode =='pie'){		
	var title = "Mortality Percentages of ${param.topic_title} who were not Prescribed Metformin";
	$("#mortality-title2").text(title);
} else if (title_mode == 'bar'){
	var title = "Counts of ${param.topic_title} who were not Prescribed Metformin by Mortality";
	$("#mortality-title2").text(title);
} else {
	var title = "Mortality Percentages of ${param.topic_title} who were not Prescribed Metformin";
	$("#mortality-title2").text(title);
};

//this is to change the title of the graphic based on which visualization mode is selected
$('#${param.block}-mode-barpercent').on('mouseup', function() {
	var title = "Mortality Percentages of ${param.topic_title} who were not Prescribed Metformin";
	$("#mortality-title2").text(title);
});
$('#${param.block}-mode-bar').on('mouseup', function() {
	var title = "Counts of ${param.topic_title} who were not Prescribed Metformin by Mortality";
	$("#mortality-title2").text(title);
});
$('#${param.block}-mode-pie').on('mouseup', function() {
	var title = "Mortality Percentages of ${param.topic_title} who were not Prescribed Metformin";
	$("#mortality-title2").text(title);
});



function ${param.block}_mortality_refresh() {
	var properties1 = {
			domName: '#${param.block}_mortality1_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: mortality_range,
			legend_label: 'Mortality',
			legend_data: mortality_legend,
			donutRatio: 0.5
		}
	
	var properties2 = {
			domName: '#${param.block}_mortality2_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: mortality_range,
			legend_label: 'Mortality',
			legend_data: mortality_legend,
			donutRatio: 0.5
		}

	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	d3.select("#${param.block}_mortality1_viz").select("svg").remove();
	d3.select("#${param.block}_mortality2_viz").select("svg").remove();
	
	if (mode =='pie'){		
		localPieChart_new(${param.block}_MortalityMetArray, properties1);
		localPieChart_new(${param.block}_MortalityNoMetArray, properties2);
	} else if (mode == 'bar'){
		localHorizontalBarChart_new(${param.block}_MortalityMetArray, properties1);
		localHorizontalBarChart_new(${param.block}_MortalityNoMetArray, properties2);
	} else {
		localPercentageBarChart_new(${param.block}_MortalityMetArray, properties1);
		localPercentageBarChart_new(${param.block}_MortalityNoMetArray, properties2);
	};

	
}

${param.block}_mortality_refresh();

</script>
