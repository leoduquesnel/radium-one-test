$ ->
  bindStockTickers()
  window.setInterval (e) ->
    loadStockPricesChart(true)
  , 1000

bindStockTickers = () ->
  $(".stock-ticker-select").click (e) ->
    e.preventDefault()

    $(".stock-ticker-select").removeClass('active')
    $(this).toggleClass('active')

    $(".add-value-btn input[type=submit]").removeClass('disabled')
    $("#stock_price_stock_ticker_id").val($(this).data('id'))

    window.loadStockPricesChart(!$("#stock-prices-chart-wrapper").is(':empty'))

window.loadStockPricesChart = (update = false) ->
  stock_ticker_id = $("#stock_price_stock_ticker_id").val()
  if stock_ticker_id
    if update == false
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

    svg = d3.select("#stock-prices-chart-wrapper")
    if update == false
      svg = svg.append("svg")
          .attr("width", width + margin.left + margin.right)
          .attr("height", height + margin.top + margin.bottom)
        .append("g")
          .attr("transform", "translate(" + margin.left + "," + margin.top + ")")

    limit = if $("#days").val() > 0 then '?limit=' + $("#days").val() else ''

    d3.json '/stock_tickers/' + stock_ticker_id + '.json' + limit, (error, data) ->
      if error
        throw error

      parseDate = d3.time.format("%d-%m-%Y").parse
      price.date = parseDate(price.date) for price in data

      x.domain(d3.extent(data, (d) -> return d.date ))
      y.domain(d3.extent(data, (d) -> return d.price ))

      x_axis = if update == true then svg.selectAll("g.x.axis") else svg.append("g")
      x_axis.attr("class", "x axis")
          .attr("transform", "translate(0," + height + ")")
          .call(xAxis)


      y_axis = if update == true then svg.selectAll("g.y.axis") else svg.append("g")
      y_axis.attr("class", "y axis")
        .call(yAxis)
      if update == false
        y_axis.append("text")
          .attr("transform", "rotate(-90)")
          .attr("y", 6)
          .attr("dy", ".71em")
          .style("text-anchor", "end")
          .text("Price ($)")

      line_path = if update == true then svg.selectAll("path.line") else svg.append("path")
      line_path.datum(data)
          .attr("class", "line")
          .attr("d", line)