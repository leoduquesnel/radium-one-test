$ ->
  bindStockTickers()

bindStockTickers = () ->
  $(".stock-ticker-select").click (e) ->
    e.preventDefault()

    $(".stock-ticker-select").removeClass('active')
    $(this).toggleClass('active')

    $(".add-value-btn input[type=submit]").removeClass('disabled')
    $("#stock_price_stock_ticker_id").val($(this).data('id'))

    window.loadStockPricesHighStock()

window.requestData = (chart, url) ->
  setTimeout(() ->
    $.getJSON url, (data) ->
      data = data.map (current) -> [Date.parse(current.date), current.price]
      chart.options.series[0].data = data
      setTimeout(window.requestData(chart, url), 1000)
  , 1000)
  
window.clearIntervals = () ->
  i = 1
  while i++ < 99
    window.clearInterval i

window.loadStockPricesHighStock = () ->
  stock_ticker_id = $("#stock_price_stock_ticker_id").val()
  url = '/stock_tickers/' + stock_ticker_id + '.json'

  if stock_ticker_id
    chart = new Highcharts.StockChart({
      chart: {
        renderTo: 'stock-prices-highstock-wrapper'
        type: 'spline'
        events: {
          load: () ->
            $.getJSON url, (data) ->
              data = data.map (current) -> [Date.parse(current.date), current.price]
              chart.series[0].setData(data) 
        } 
      }
      rangeSelector: {
        selected: 0
      }
      title: {
        text: $(".stock-ticker-select.active").text() + ' stocks prices'
      }
      yAxis: {
          title: {
              text: 'Prices ($)'
          }
      }
      xAxis: {
        type: 'datetime'
      }
      series: [{
          name: 'Stock price'
          data: []
      }]
    })

    window.clearIntervals()

    setInterval (e) ->
      $.getJSON url, (data) ->
        data = data.map (current) -> [Date.parse(current.date), current.price]
        chart.series[0].setData(data) 
    , 500
