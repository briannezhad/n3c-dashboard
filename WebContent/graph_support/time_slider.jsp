 <style>

/*     #play-button { */
/*       background: #f08080; */
/*       padding-right: 26px; */
/*       border-radius: 3px; */
/*       border: none; */
/*       color: white; */
/*       margin: 0; */
/*       padding: 0 12px; */
/*       width: 60px; */
/*       cursor: pointer; */
/*       height: 30px; */
/*     } */

/*     #play-button:hover { */
/*       background-color: #696969; */
/*     }     */
    
    .ticks {
      font-size: 10px;
    }

    .track,
    .track-inset,
    .track-overlay {
      stroke-linecap: round;
    }

    .track {
      stroke: #000;
      stroke-opacity: 0.3;
      stroke-width: 10px;
    }

    .track-inset {
      stroke: #dcdcdc;
      stroke-width: 8px;
    }

    .track-overlay {
      pointer-events: stroke;
      stroke-width: 50px;
      stroke: transparent;
      cursor: crosshair;
    }

    .handle {
      fill: #fff;
      stroke: #000;
      stroke-opacity: 0.5;
      stroke-width: 1.25px;
    }
  </style>

<div id="vis-button">
  
</div>
<div id="vis">
</div>
<script>

var formatDateIntoYear = d3.timeFormat("%Y");
var formatDate = d3.timeFormat("%m/%Y");
var parseDate = d3.timeParse("%m/%d/%y");

var formatTick = function(date){
	if (d3.timeYear(date) < date) {
        return d3.timeFormat('%b')(date);
      } else {
        return d3.timeFormat('%Y')(date);
      }
   };

var startDate = new Date("2020-01-01"),
    endDate = new Date("2022-08-01");

var margin = {top:0, right:50, bottom:0, left:50},
    width = 860 - margin.left - margin.right,
    height = 50 - margin.top - margin.bottom;

var svg = d3.select("#vis")
    .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom);  

////////// slider //////////

var moving = false;
var currentValue = 0;
var targetValue = width;

var playButton = d3.select("#play-button");
    
var x = d3.scaleTime()
    .domain([startDate, endDate])
    .range([0, targetValue])
    .clamp(true);

var slider = svg.append("g")
    .attr("class", "slider")
    .attr("transform", "translate(" + margin.left + "," + height/5 + ")");

slider.append("line")
    .attr("class", "track")
    .attr("x1", x.range()[0])
    .attr("x2", x.range()[1])
  .select(function() { return this.parentNode.appendChild(this.cloneNode(true)); })
    .attr("class", "track-inset")
  .select(function() { return this.parentNode.appendChild(this.cloneNode(true)); })
    .attr("class", "track-overlay")
    .call(d3.drag()
        .on("start.interrupt", function() { slider.interrupt(); })
        .on("start drag", function() {
          currentValue = d3.event.x;
          update(x.invert(currentValue)); 
        })
    );

slider.insert("g", ".track-overlay")
    .attr("class", "ticks")
    .attr("transform", "translate(0," + 18 + ")")
  .selectAll("text")
    .data(x.ticks(d3.timeMonth.every(1)))
    .enter()
    .append("text")
    .attr("x", x)
    .attr("y", 10)
    .attr("text-anchor", "middle")
    .text(function(d) { return formatTick(d); });
    

var handle = slider.insert("circle", ".track-overlay")
    .attr("class", "handle")
    .attr("r", 9);

var label = slider.append("text")  
    .attr("class", "label")
    .attr("text-anchor", "middle")
    .text(formatDate(startDate))
    .attr("transform", "translate(0," + (-25) + ")")

 
////////// plot //////////

  playButton
    .on("click", function() {
    var button = d3.select(this);
    console.log(button.html());
    if (button.html() == '<i class="fas fa-pause-circle" aria-hidden="true"></i>') {
      moving = false;
      clearInterval(timer);
      // timer = 0;
      button.html('<i class="fas fa-play-circle"></i>');
    } else {
      moving = true;
      timer = setInterval(step, 100);
      button.html('<i class="fas fa-pause-circle"></i>');
    }
    console.log("Slider moving: " + moving);
  })

function step() {
  update(x.invert(currentValue));
  currentValue = currentValue + (targetValue/151);
  if (currentValue > targetValue) {
    moving = false;
    currentValue = 0;
    clearInterval(timer);
    // timer = 0;
    playButton.text("Play");
    console.log("Slider moving: " + moving);
  }
}

function update(h) {
	console.log("update", h, formatDate(h))
  // update position and text of label according to slider scale
  handle.attr("cx", x(h));
  label
    .attr("x", x(h))
    .text(formatDate(h));

  ${param.block}_constrain_table("subsequent_infection", formatDate(h));
}
</script>
