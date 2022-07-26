<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>


<jsp:include page="../vizs/stacked_bar2.jsp">
	<jsp:param name="domName" value= "${param.domName}" />
	<jsp:param name="feed" value= "${param.feed}" />
	<jsp:param name="primary" value= "${param.primary}" />
	<jsp:param name="secondary" value= "${param.secondary}" />
	<jsp:param name="textmargin" value= "${param.textmargin}" />
</jsp:include>

<script>

function drugconstrain(filter, constraint) {
	var table1 = $('#drugs_viz_table-table').DataTable();
	switch (filter) {
	case 'result':
	    table1.column(1).search(constraint, true, false, true).draw();	
		break;
	}
}

$.getJSON("<util:applicationRoot/>/new_ph/paxlovid/feeds/topten_drugs_long.jsp", function(data){
	
	
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover compact site-wrapper';
	table.style.width = '100%';
	table.id="${param.table}-table";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("${param.table}");
	divContainer.appendChild(table);

	var data = json['rows'];

	drugdatatable2 = $('#drugs_viz_table-table').DataTable( {
    	data: data,
    	dom: 'lfr<"datatable_overflow"t>Bip',
       	paging: true,
    	pageLength: 10,
    	lengthMenu: [ 10, 25, 50, 75, 100 ],
    	order: [[0, 'asc']],
     	columns: [
        	{ data: 'medication', visible: true, orderable: true },
        	{ data: 'values', visible: true, orderable: true},
        	{ data: 'count', visible: true, orderable: true}
    	]
	} );
	
	// table search logic that distinguishes sort/filter 
	drugdatatable2.on( 'search.dt', function () {
		var data = drugdatatable2.rows({ search: 'applied', order: 'index'}).data().toArray();
		$('#drugs_viz').find('svg').remove();
		drawthesebars(clean_data(data));
	} );
	
	
	function clean_data(data_rows){
		if (data_rows.length == 0){
			return [];
		}
		var data = [];
		var med = '';
		var total = 0;
		var group = '';
		var negative = 0;
		var positive = 0;
		var unknown = 0;
		var element = {};
		var secondary = [0, 0, 0, 0];
		var row_med = '';
		for (i in data_rows){
			row = data_rows[i];
			row_med = row.${param.primary};
			if (row_med != med){
				group = row_med;
				if (i != 0){
					element['secondary'] = secondary;
					element['count'] = total;
					data.push(element);
					element = {};
					total = 0;
					negative = 0;
					positive = 0;
					unknown = 0;
					secondary = [0, 0, 0, 0];
				}
			}
			if (row_med == group){
	 			var test = row_med;
	 			var trimmedString = test.substring(0, 20);
	 			if (trimmedString != test){
	 				trimmedString = trimmedString + '...'
	 			}
	 			element['element'] = trimmedString;
				element['element2'] = row_med;
				if (row.values == 'Positive'){
					positive = row.count;
					total += positive;
					secondary[1]= positive;
				};
				if (row.values == 'Negative'){
					negative = row.count;
					total += negative;
					secondary[2] = negative;
				};
				if (row.values == 'Unknown'){
					unknown = row.count;
					total += unknown;
					secondary[3] = unknown;
				};
			}
			if (i == (data_rows.length-1)){
				element['secondary'] = secondary;
				element['count'] = total;
				data.push(element);
			}
			med = row['${param.primary}'];
		}
		var data2 = data.sort(({count:a}, {count:b}) => b-a);
		return data2;
	}
	
	drawthesebars(clean_data(data));
});



</script>



