$(document).ready(function(){
  $('#graph').load(loadGraph);
});

var loadGraph = function() {
//Add vertical line to denote where the user is.
  $.ajax({
           type: "GET",
           contentType: "application/json; charset=utf-8",
           url: '/bills/comparison.json',
           dataType: 'json',
           success: function (data) {
              console.log(data);
              data.comparison_bills.forEach(function(d) {
                d.amount = parseFloat(d.amount);
              });
              var arr = [];
              for(i = 0; i < data.comparison_bills.length; i++) {
                arr.push(data.comparison_bills[i].amount);
              }
              arr.sort(d3.ascending);
              var current_user_amount;
              for(i = 0; i < data.comparison_bills.length; i++) {
                if(data.comparison_bills[i].user_id == data.current_user_id) {
                  current_user_amount = data.comparison_bills[i].amount
                }
              }
              console.log("current_user_amount " + current_user_amount);
              console.log(arr);
              draw(arr, current_user_amount);
           },
           error: function (result) {
              error();
           }
       });
};

function draw(data, current_user_amount) {
    var color = d3.scale.category20b();
    var margin = {top: 20, right: 30, bottom: 30, left: 40},
        width = parseInt(d3.select(".small-centered").style("width")) - margin.left - margin.right,
        height = parseInt(d3.select(".small-centered").style("height")) - margin.top - margin.bottom;

    var barWidth = width / data.length;

    var x = d3.scale.ordinal()
        .rangeRoundBands([0, width], .1);

    var y = d3.scale.linear()
        .range([height, 0])
        .domain([0, d3.max(data)]);

    var xAxis = d3.svg.axis()
        .scale(x)
        .orient("bottom");

    var yAxis = d3.svg.axis()
        .scale(y)
        .orient("left");

    var chart = d3.select("#graph")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    var bar = chart.selectAll("g")
        .data(data)
        .enter().append("g")
        .attr("transform", function(d, i) { return "translate(" + i * barWidth + ",0)"; })
        .style("fill", function (d) { if(d == current_user_amount) { return "red"; } else {return color(d) }});

    bar.append("rect")
        .attr("y", y)
        .attr("width", barWidth - 1)
        .attr("height", function(d) { return height - y(d); });

    bar.append("text")
        .style("fill", "blue")
        .attr("x", barWidth/2)
        .attr("y", y)
        .attr("text-anchor", "middle")
        .attr("dy", "1em")
        .text(function(d) { if(d == current_user_amount) { return "Your bill" }});

    chart.append("g")
        .attr("class", "y axis")
        .call(yAxis)
        .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text("Amount in Dollars");
}

function error() {
    console.log("error")
}

function type(d) {
  d.value = +d.value; // coerce to number
  return d;
}
