chart = new (google.visualization.GeoChart)(document.getElementById('geo-chart-container'))
data = google.visualization.arrayToDataTable([
  [
    'Country'
    'Tweets'
  ]
  <%= raw @tweets_array.to_s.gsub("[[","[").gsub("]]", "]") %>
])
chart.draw data
google.visualization.events.addListener chart, 'select', ->
  selectedItem = chart.getSelection()[0]
  country = data.getValue(selectedItem.row, 0)
  search = $('#search_hash')[0].value.replace('#','')
  window.location.href = window.location.href + 'tweets/' + country + '?search=' + search
