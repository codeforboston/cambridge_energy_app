$(document).ready(function(){
  $('#graph').append(loadGraph);
});

var loadGraph = function() {
    //Add vertical line to denote where the user is.
    $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        url: '/bills/comparison.json',
        dataType: 'json',
        success: function(data) {
            var arr = [];
            data.comparison_bills.forEach(function(d) {
                d.amount = +d.amount;
                arr.push({ amount: d.amount, user: d.user_id, id: d.id });
            });
            draw(arr, data.current_user_id, data.most_recent_bill_id);
        },
        error: function(result) {
            error();
        }
    });
};


function draw(data, current_user_id, last_bill) {
    var color = d3.scale.category20b();
    var margin = {top: 20, right: 30, bottom: 30, left: 40},
        totalWidth = parseInt(d3.select(".small-centered").style("width")),
        width = totalWidth - margin.left - margin.right,
        totalHeight = parseInt(d3.select(".small-centered").style("height")), 
        height = totalHeight - margin.top - margin.bottom;

    var barWidth = width / data.length;

    var x = d3.scale.ordinal()
        .rangeRoundBands([0, width], .1);

    var y = d3.scale.linear()
        .range([height, 0])
        .domain([0, d3.max(data, function(d) { return d.amount; })]);

    var xAxis = d3.svg.axis()
        .scale(x)
        .orient("bottom");

    var yAxis = d3.svg.axis()
        .scale(y)
        .orient("left");

    var chart = d3.select("#graph")
        .style("width", totalWidth + 'px')
        .style("height", totalHeight + 'px')
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    var bar = chart.selectAll("g")
        .data(data)
        .enter().append("g")
        .attr("transform", function(d, i) { return "translate(" + i * barWidth + ",0)"; })
        .style("fill", "blue");

    bar.append("rect")
        .attr("y", function(d) { return y(d.amount) })
        .attr("width", barWidth - 1)
      	.attr("height", function(d) { return height-y(d.amount); })
        .style("fill", function (d) { if(d.id == last_bill) { return "red"; } });

    chart.append("g")
        .attr("class", "y axis")
        .call(yAxis)
        .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 0)
        .attr("dy", "-2.6em")
        .style("text-anchor", "end")
        .text("Amount in Kilowatt Hours");
}

function error() {
    console.log("error")
}
