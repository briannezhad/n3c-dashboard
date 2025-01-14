<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<script>

function ${param.block}_constrain_table(filter, constraint) {
	// console.log("timeline constraint", filter, constraint);
	var table = $('#${param.target_div}-table').DataTable();
	
	switch (filter) {
	case 'region':
		table.column(0).search(constraint, true, false, true).draw();	
		break;
	case 'severity':
		table.column(1).search(constraint, true, false, true).draw();	
		break;
	}
	
	var kpis = '${param.target_kpis}'.split(',');
	for (var a in kpis) {
		${param.block}_updateKPI(table, kpis[a])
	}
}

function ${param.block}_updateKPI(table, column) {
	var sum_string = '';
	var sumString = '';
	// console.log(column);
	if (column != 'region_seq'){	
		var sum = table.rows({search:'applied'}).data().pluck(column).sum();
		if (sum < 1000) {
			sumString = sum+'';
		} else if (sum < 1000000) {
			sum = sum / 1000.0;
			sumString = sum.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + "k";
		} else {
			sum = sum / 1000000.0;
			sumString = sum.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + "M";
		}
	} else {
		var sum = 0;
		var data = table.rows({search:'applied'}).data().toArray();
		var unique = [];
		for (i in data){
			if (unique.indexOf(data[i].region) === -1){
				unique.push(data[i].region);
				sum += data[i].region_seq;
			}
		}
		//var number = table.$('tr', {"filter":"applied"}).length;
		sumString = sum + '' ;
	}
	document.getElementById('${param.block}'+'_'+column+'_kpi').innerHTML = sumString;
}

jQuery.fn.dataTable.Api.register( 'sum()', function ( ) {
	return this.flatten().reduce( function ( a, b ) {
		if ( typeof a === 'string' ) {
			a = a.replace(/[^\d.-]/g, '') * 1;
		}
		if ( typeof b === 'string' ) {
			b = b.replace(/[^\d.-]/g, '') * 1;
		}

		return a + b;
	}, 0 );
} );

$(document).ready( function () {
		 
	$.getJSON("<util:applicationRoot/>/new_ph/${param.feed}", function(data){
			
		var json = $.parseJSON(JSON.stringify(data));
	
		var col = [];
	
		for (i in json['headers']){
			col.push(json['headers'][i]['label']);
		}
	
	
		var table = document.createElement("table");
		table.className = 'table table-hover compact site-wrapper';
		table.style.width = '100%';
		table.id="${param.target_div}-table";
	
		var header= table.createTHead();
		var header_row = header.insertRow(0); 
	
		for (i in col) {
			var th = document.createElement("th");
			th.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">' + col[i].toString() + '</span>';
			header_row.appendChild(th);
		}
	
		var divContainer = document.getElementById("${param.target_div}");
		divContainer.appendChild(table);
	
		var data = json['rows'];
	
		var ${param.block}_datatable = $('#${param.target_div}-table').DataTable( {
	    	data: data,
	    	dom: 'lfr<"datatable_overflow"t>Bip',
	    	buttons: {
	    	    dom: {
	    	      button: {
	    	        tag: 'button',
	    	        className: ''
	    	      }
	    	    },
	    	    buttons: [{
	    	      extend: 'csv',
	    	      className: 'btn btn-sm btn-light',
	    	      titleAttr: 'CSV export.',
	    	      text: 'CSV',
	    	      exportOptions: {
	                  columns: ':visible'
	              },
	    	      filename: 'regional_distribution',
	    	      extension: '.csv'
	    	    }, {
	    	      extend: 'copy',
	    	      className: 'btn btn-sm btn-light',
	    	      titleAttr: 'Copy table data.',
	    	      exportOptions: {
	                  columns: ':visible'
	              },
	    	      text: 'Copy'
	    	    }]
	    	},
	       	paging: true,
	       	snapshot: null,
	       	initComplete: function( settings, json ) {
	       	 	settings.oInit.snapshot = $('#${param.target_div}-table').DataTable().rows({order: 'index'}).data().toArray().toString();
	       	 	setTimeout(function() {jQuery('.loading').fadeOut(100); ${param.block}_refreshHistograms();}, 500);
	       	},
	    	pageLength: 10,
	    	lengthMenu: [ 10, 25, 50, 75, 100 ],
	    	order: [[0, 'asc']],
	     	columns: [
	        	{ data: 'region', visible: true, orderable: true },
	        	{ data: 'severity', visible: true, orderable: true },
	        	{ data: 'patient_count', visible: true, orderable: true },
	        	{ data: 'region_seq', visible: true, orderable: true }
	    	]
		} );
		
		// table search logic that distinguishes sort/filter 
		${param.block}_datatable.on( 'search.dt', function () {
			var snapshot = ${param.block}_datatable
		     .rows({ search: 'applied', order: 'index'})
		     .data()
		     .toArray()
		     .toString();

		  	var currentSnapshot = ${param.block}_datatable.settings().init().snapshot;

		  	if (currentSnapshot != snapshot) {
		  		${param.block}_datatable.settings().init().snapshot = snapshot;
		  		${param.block}_refreshHistograms();
				${param.block}_constrain_table();
		   		$('#${param.block}_btn_clear').removeClass("no_clear");
		   		$('#${param.block}_btn_clear').addClass("show_clear");
		  	}
		} );
		
	});
	

	
	
});
</script>
