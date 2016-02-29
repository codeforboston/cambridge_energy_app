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

function draw(data, current_user_amount) {
    var color = d3.scale.category20b();
    var width = parseInt(d3.select(".small-centered").style("width")),
        height = parseInt(d3.select(".small-centered").style("height"));

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
        .style("fill", function (d) { if(d == current_user_amount) { return "blue"; } else {return color(d) }});

    bar.append("rect")
        .attr("y", y)
        .attr("width", barWidth - 1)
        .attr("height", function(d) { return height - y(d); });
}

function error() {
    console.log("error")
}

function type(d) {
  d.value = +d.value; // coerce to number
  return d;
}