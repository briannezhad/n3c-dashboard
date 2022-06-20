<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<script>


// set the dimensions and margins of the graph
var individual_symptom_margin = {top: 0, right: 0, bottom: 10, left: 0},
	individual_symptom_width = 445 - individual_symptom_margin.left - individual_symptom_margin.right,
	individual_symptom_height = 445 - individual_symptom_margin.top - individual_symptom_margin.bottom;


// read json data
d3.json("<util:applicationRoot/>/new_ph/summary_blocks/long_summary_block_vizs/${param.feed}", function(error, data) {
	if (error) throw error;
	
	var ${param.container}myObserver = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = Math.floor(entry.contentRect.width);
			if (newWidth > 0) {
				d3.select("#${param.container}").select("svg").remove();
				individual_symptom_width = newWidth - individual_symptom_margin.left - individual_symptom_margin.right;
				if ((individual_symptom_width/2 - individual_symptom_margin.top - individual_symptom_margin.bottom) > 300){
					individual_symptom_height = individual_symptom_width/2 - individual_symptom_margin.top - individual_symptom_margin.bottom;
				} else { 
					individual_symptom_height = 300;
				}
				draw();
				
			}
		});
	});

	${param.container}myObserver.observe(d3.select("#${param.container}").node());

	draw();

	function draw(){
        
		// append the svg object to the body of the page
		var svg = d3.select("#${param.graph_element}")
		.append("svg")
		  .attr("width", individual_symptom_width + individual_symptom_margin.left + individual_symptom_margin.right)
		  .attr("height", individual_symptom_height + individual_symptom_margin.top + individual_symptom_margin.bottom)
		
		var g = svg.append("g")
		  .attr("transform", "translate(" + individual_symptom_margin.left + "," + individual_symptom_margin.top + ")")
		  .attr("id", "svg_g");
		
		// Give the data to this cluster layout:
		var root = d3.hierarchy(data).sum(function(d){ return d.value}) // Here the size of each leave is given in the 'value' field in input data
	
		
		// get min and max while also sorting the array
		var min = data.children.sort( 
				  function(a, b) {
					     return parseFloat(a['value']) - parseFloat(b['value']);
					  }
					)[0]['value']
		
		var max = data.children.sort( 
				  function(a, b) {
					     return parseFloat(b['value']) - parseFloat(a['value']);
					  }
					)[0]['value']

		
		var color_scale = d3.scaleLinear()
        .domain([min,max])
        .range(["${param.color_start}", "${param.color_end}"]); 
			
	  
		// Then d3.treemap computes the position of each element of the hierarchy
		d3.treemap()
			.size([individual_symptom_width, individual_symptom_height])
			.padding(2)
			(root);
	
		// use this information to add rectangles:
		g.selectAll("rect")
			.data(root.leaves())
			.enter()
			.append("a")
    			.attr("xlink:href", function(d) {return "<util:applicationRoot/>" + "/new-ph/long-covid/" + d.data.viz_id;})
				.append("rect")
					.style("cursor", "pointer")
					.attr('x', function (d) { return d.x0; })
					.attr('y', function (d) { return d.y0; })
					.attr('width', function (d) { return d.x1 - d.x0; })
					.attr('height', function (d) { return d.y1 - d.y0; })
					.style("fill",  function (d) { return color_scale(d.value); });
	
		function nFormatter(num, digits) {
			  const lookup = [
			    { value: 1, symbol: "" },
			    { value: 1e3, symbol: "k" },
			    { value: 1e6, symbol: "M" },
			    { value: 1e9, symbol: "G" },
			    { value: 1e12, symbol: "T" },
			    { value: 1e15, symbol: "P" },
			    { value: 1e18, symbol: "E" }
			  ];
			  const rx = /\.0+$|(\.[0-9]*[1-9])0+$/;
			  var item = lookup.slice().reverse().find(function(item) {
			    return num >= item.value;
			  });
			  return item ? (num / item.value).toFixed(digits).replace(rx, "$1") + item.symbol : "0";
		};
		
		// and to add the text labels
		g.selectAll("text")
			.data(root.leaves())
			.enter()
			.append("a")
    			.attr("xlink:href", function(d) {return "<util:applicationRoot/>" + "/new-ph/summary/long-covid/" + d.data.viz_id;})
				.append("text")
					.style("cursor", "pointer")
					.attr("x", function(d){ return d.x0+5})    // +10 to adjust position (more right)
					.attr("y", function(d){ return d.y0+20})    // +20 to adjust position (lower)
					.text(function(d){ return d.data.symptom + ' (' + nFormatter(d.data.value, 2) + ')' })
					.attr("font-size", "16px")
					.attr("fill", "white");
		
	}
})
</script>