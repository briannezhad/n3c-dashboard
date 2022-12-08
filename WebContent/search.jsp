<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html>
<html>

<style>
.section{
	margin-bottom:100px;
}

.section-description{
	margin-top: 30px;
	margin-bottom: 60px;
}

.analysis label i{
	color: #0b4865;
}
.overview label i{
	color: #4933b1; 
} 
.about label i{ 
	color: gray; 
}
.iconanalysis:before{
	color: #0b4865;
	font-family: "Font Awesome 5 Free";
	font-weight: 900;
	content: "\f200";
}
.iconoverview:before{
	color: #4933b1;
	font-family: "Font Awesome 5 Free";
	font-weight: 900;
	content: "\f1c0";
}
.iconabout:before{
	color: gray;
	font-family: "Font Awesome 5 Free";
	font-weight: 900;
	content: "\f05a";
}

#search_table_section .form-check label{ 
	font-size: 1.4rem; 
	color: #222;
}

.publication-panel-group .badge{
	font-size: 18px;
   	font-weight: 300;
   }
   
.title{
   	font-size: 1.3rem;
   	line-height: 1;
   	font-weight: 400;
   	color: #222;
}
    
</style>

<jsp:include page="head.jsp" flush="true" />

<body>
	<jsp:include page="navbar.jsp" flush="true"/>
	
	<div class="container content">
		<div class="row page-title">
			<div class="col-12">
				<h1>Dashboard Search</h1>
			</div>
		</div>
		<div class="section">
			<div class="row justify-content-center">
				<div class="col-12 col-sm-10">
					<div id="search_table_section">
						<div style="text-align:center; margin-bottom:30px;">
							<div class="form-check form-check-inline analysis">
	  							<input name="dash_type" class="form-check-input filter" type="checkbox" id="inlineCheckbox1" value="analysis">
	  							<label class="form-check-label" for="inlineCheckbox1"><i class="fas fa-chart-pie"></i>  Analysis</label>
							</div>
							<div class="form-check form-check-inline overview">
	  							<input name="dash_type" class="form-check-input filter" type="checkbox" id="inlineCheckbox2" value="overview">
	  							<label class="form-check-label" for="inlineCheckbox2"><i class="fas fa-database"></i>  Data Overview</label>
							</div>
							<div class="form-check form-check-inline about">
	 							<input name="dash_type" class="form-check-input filter" type="checkbox" id="inlineCheckbox3" value="about">
	  							<label class="form-check-label" for="inlineCheckbox3"><i class="fas fa-info-circle"></i>  N3C About</label>
							</div>
						</div>
						<div id="search-list" class="text-max mx-auto"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	

	<jsp:include page="footer.jsp" flush="true" />
	
</body>
<script>

function getUrlVars() {
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
} 

$(document).ready( function () {
	$.getJSON("<util:applicationRoot/>/search.json", function(data){
		var searchTerm = getUrlVars()['search'];
		var json = $.parseJSON(JSON.stringify(data));
	
		var col = [];
	
		for (i in json['headers']){
			col.push(json['headers'][i]['label']);
		}
	
	
		var table = document.createElement("table");
		table.className = 'table table-hover table-expand';
		table.style.width = '100%';
		table.style.textAlign = "left";
		table.id="search_table";
	
		var header= table.createTHead();
		var header_row = header.insertRow(0); 
	
		for (i in col) {
			var th = document.createElement("th");
			th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
			header_row.appendChild(th);
		}
	
		var divContainer = document.getElementById("search-list");
		divContainer.innerHTML = "";
		divContainer.appendChild(table);
	
		var data = json['rows'];
	
		$('#search_table').DataTable( {
	    	data: data,
	    	search: {
	            search: searchTerm
	        },
	       	paging: true,
	       	dom: 'lfr<"datatable_overflow"t>ip',
	       	language: {
	            searchPlaceholder: "title, keyword, description ..."
	        },
	    	pageLength: 5,
	    	drawCallback: function( settings ) {$("#search_table thead").remove(); } ,
	    	lengthMenu: [ 5, 10, 25, 50, 75, 100 ],
	    	order: [[2, 'asc']],
	     	columns: [
	     		{ data: 'dashboard_id', 
	     			orderable: false,
	     			className: 'noExport',
	     			render: function ( data, type, row ) {
	     				var id = row.dashboard_id;
	        			var title = row.dashboard_name;
	        			var desc = row.dashboard_short_desc;
	        			var url = row.dashboard_url;
	        			var image = row.image;
	        			var type = row.type;
	        			
	        			var list = type.split(",");
	        			var icons = '';
	        			
	        			for (i in list){
	        				var icon_code = ' <span class="icon' + list[i].trim() + '"></span>';
	        				icons = icons + icon_code;
	        			}
	        			
	        			console.log(url);
	        			var combo = 
	        				'<div class="row"><div class="col-4"><img src="<util:applicationRoot/>/images/dashboards/'
	        				+ image
	        				+'" class="card-img-top" alt="..."></div><div class="col-8"><p class="mb-3 title">'
	        				+ title 
	        				+ '</p> <p>'
	        				+ desc
	        				+ '</p><div>'
	        				+ icons 
	        				+ '<div class="float-right"><a href="<util:applicationRoot/>'
	            				+ url
	            				+ '" >Explore&#8196;<i class="fas fa-angle-right"></i></a></div>'
	        				+'</div></div></div>';
	             		return combo; }
	     		},
	        	{ data: 'tags', visible: false },
	        	{ data: 'dashboard_name', visible: false },
	        	{ data: 'dashboard_url', visible: false },
	        	{ data: 'dashboard_short_desc', visible: false },
	        	{ data: 'image', visible: false },
	        	{ data: 'type', visible: false }
	    	]
		} );
	
		
	});
	
	$.fn.dataTable.ext.search.push(
		function( settings, searchData, index, rowData, counter ) {
			var positions = $('#search_table_section input:checkbox[name="dash_type"]:checked').map(function() {
				return this.value;
			}).get();
		   
			var list = searchData[6].split(",");
			if (positions.length === 0) {
				return true;
			}
			for (i in list){
				if (positions.indexOf(list[i].trim()) !== -1) {
					return true;
				}
			}
			return false;

		}
	);
	  
	$('#search_table_section input:checkbox').on('change', function () {
		$('#search_table').DataTable().draw();
	});
});
</script>
</html>