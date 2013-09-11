Q = require 'q'
request = require 'request'
jsdom = require 'jsdom'

stationId = (stationName) ->
  deferred = Q.defer()
  
  url = "http://www.nordwestbahn.de/informationen/abfahrtsmonitor.html?input=#{stationName}&eID=tx_elementeabfahrtsmonitor_pi1"
  request url, (err, response, data) ->
    stationIds = JSON.parse data
    if err? then return deferred.reject new Error err
    return deferred.resolve stationIds
  
  deferred.promise
    
timetable = (stationId) ->
  deferred = Q.defer()
  
  url = "http://www.nordwestbahn.de/informationen/abfahrtsmonitor.html?type=13071978&tx_elementeabfahrtsmonitor_pi1[id]=#{stationId}"
  jsdom.env url, ['http://code.jquery.com/jquery.js'], (err, window) ->
    $ = window.$
    $departures = ($(el) for el in $('tr')[1..-2])
    
    departures = for key, $el of $departures
      col = $el.find('td')
      
      # hacking for train
      col2 = $(col[2]).html()
      trainInfos = col2.split '<br />'
      trainInfos[0] = trainInfos[0].split(' - ')
      
      re = /\s/gi
      
      train = 
        id: trainInfos[0][0].replace(re, '')
        line: trainInfos[0][1].replace(re, '')
        name: trainInfos[1].replace(re, '') if trainInfos[1]?
      
      depature = 
        std: $(col[0]).text() # scheduled time of departure
        etd: $(col[1]).text() # estimated time of departure
        train: train
        direction: $(col[3]).find('h4').text()
        info: $(col[4]).text()
    
    deferred.resolve departures
  
  deferred.promise

exports.stationId = stationId
exports.timetable = timetable