<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div id="analysis1-hazard"></div>
<script>
$.getJSON("../../phastr/pasc-mortality/feeds/analysis1_hazard.jsp", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover';
	table.style.width = '100%';
	table.style.textAlign = "left";
	table.id="analysis1-hazard-table";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("analysis1-hazard");
	divContainer.innerHTML = "";
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#analysis1-hazard-table').DataTable( {
    	data: data,
       	paging: true,
    	pageLength: 5,
    	dom: 'lfr<"datatable_overflow"t>Bip',
    	lengthMenu: [ 5, 10, 25, 50, 75, 100 ],
    	order: [[0, 'asc']],
     	columns: [
        	{ data: 'element', visible: true, orderable: true },
        	{ data: 'estimate', visible: true, orderable: true, className: "text-right" },
        	{ data: 'exp_coef', visible: true, orderable: true, className: "text-right" },
        	{ data: 'se_coef', visible: true, orderable: true, className: "text-right" },
        	{ data: 'z', visible: true, orderable: true, className: "text-right" },
        	{ data: 'p', visible: true, orderable: true, className: "text-right" },
        	{ data: 'x____log2p', visible: true, orderable: true, className: "text-right" },
        	{ data: 'conf_low', visible: true, orderable: true, className: "text-right" },
        	{ data: 'conf_high', visible: true, orderable: true, className: "text-right"}
    	]
	} );

	
});
</script>
