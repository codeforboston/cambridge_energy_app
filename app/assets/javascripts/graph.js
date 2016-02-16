$.ajax({
           type: "GET",
           contentType: "application/json; charset=utf-8",
           url: '/bills/comparison.json',
           dataType: 'json',
           success: function (data) {
              data.forEach(function(d) {
                d.amount = parseFloat(d.amount);
              });
              var arr = [];
              for(i = 0; i < data.length; i++) {
                arr.push(data[i].amount);
              }
              arr.sort(d3.descending);
              console.log(arr);
              draw(arr);
           },
           error: function (result) {
              error();
           }
       });
 
function draw(data) {
    var color = d3.scale.category20b();
    var width = 960,
        height = 500;

    var barWidth = width / data.length;

    var x = d3.scale.ordinal()
        .rangeRoundBands([0, width], .1);
 
    var y = d3.scale.linear()
        .range([height, 0])
        .domain([0, d3.max(data)]);
 
    var chart = d3.select("#graph")
        .attr("width", width)
        .attr("height", height);
 
    var bar = chart.selectAll("g")
        .data(data)
        .enter().append("g")
        .attr("transform", function(d, i) { return "translate(" + i * barWidth + ",0)"; })
        .style("fill", function (d) { return color(d) });
 
    bar.append("rect")
        .attr("y", function (d) { return height - y(d); })
        .attr("width", barWidth - 1)
        .attr("height", y);
}
 
function error() {
    console.log("error")
}

function type(d) {
  d.value = +d.value; // coerce to number
  return d;
}