$(document).ready ->
  drawTable = ->
    data = google.visualization.arrayToDataTable([
      [
        'Country'
        'Tweets'
      ]
    ])
    options =
      region: 'world'

    chart = new (google.visualization.GeoChart)(document.getElementById('geo-chart-container'))
    chart.draw data
    google.visualization.events.addListener chart, 'select', ->
      selectedItem = chart.getSelection()[0]
      country = data.getValue(selectedItem.row, 0)
      console.log country

  google.charts.load 'current', packages: [
    'geochart'
    'columnchart'
  ]
  google.charts.setOnLoadCallback drawTable

