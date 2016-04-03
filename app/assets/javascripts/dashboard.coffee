$ ->
  bindStockTickers()


bindStockTickers = () ->
  $(".stock-ticker-select").click (e) ->
    e.preventDefault()

    $(".stock-ticker-select").removeClass('active')
    $(this).toggleClass('active')

    fetchStockPrices($(this).data('id'))

fetchStockPrices = (id) ->
  if id
    $("#stock-prices-chart-wrapper").empty()
    
    margin = {top: 60, right: 20, bottom: 30, left: 50}
    width = 800 - margin.left - margin.right
    height = 500 - margin.top - margin.bottom

    x = d3.time.scale()
                .range([0, width])

    y = d3.scale.linear()
                .range([height, 0])


    xAxis = d3.svg.axis()
        .scale(x)
        .orient('bottom')
        .ticks(d3.time.days, 1)
        .tickFormat(d3.time.format("%d-%b"))
        .tickSize(3)

    yAxis = d3.svg.axis()
        .scale(y)
        .orient("left")

    line = d3.svg.line()
        .interpolate("basis")
        .x((d) -> return x(d.date))
        .y((d) -> return y(d.price))

    svg = d3.select("#stock-prices-chart-wrapper").append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
      .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")")

    limit = if $("#days").val() > 0 then '?limit=' + $("#days").val() else ''

    d3.json '/stock_tickers/' + id + '.json' + limit, (error, data) ->
      if error
        throw error

      parseDate = d3.time.format("%d-%m-%Y").parse
      price.date = parseDate(price.date) for price in data

      x.domain(d3.extent(data, (d) -> return d.date ))
      y.domain(d3.extent(data, (d) -> return d.price ))

      svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis)

      svg.append("g")
        .attr("class", "y axis")
        .call(yAxis)
      .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text("Price ($)")

      svg.append("path")
          .datum(data)
          .attr("class", "line")
          .attr("d", line)