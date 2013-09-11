Nordwestbahn API
================

This is an API of the German traffic enterprise NordWestBahn based in Osnabrück. The NWB train lines in the north western of Germany. So, this API Description will be in German.

Das ist eine API der NordWestBahn aus Osnabrück. Die NWB betreibt Bahnlinien im nordwesten Deutschlands, diese Implementierung greif auf die Webseite der [NWB](http://www.nordwestbahn.de) zurück. Es besteht keine Verbindung mit der NordWestBahn.

Installation
-----------
[Node.js](http://nodejs.org/) wird ab Version 0.10.x vorausgesetzt. Frühere Versionen können auch funktionieren, sind jedoch nicht getestet.

Zur Installation: `npm install nwbapi`


API
---

Die API ist mit Promisses umgesetzt. Für Details, schaue bitte auf der [GitHub-Seite des Projekte Q](https://github.com/kriskowal/q) nach.

### `nwbapi.stationId(stationName)` ###

Liefert ein Array mit Betriebsstellen zurück. Die Betriebsstellen-ID wird benötigt um eine Abfrage gegen die `nwb.timetable(stationId)` zu machen.

Beispiel: 

```
nwb.stationId('Kleve')
.then( function (stationIds) {
  console.log(stationIds);
  /*
    logs: [ { id: 'KKLV', bezeichnung: 'Kleve' } ]
  */
});
```

### `nwbapi.timetable(stationId)` ###

Liefert ein Array mit Abfahrten zurück. Die `stationId` kann mit `nwb.stationId(stationName)` geholt werden.

Beispiel: 

```
nwb.timetable('KKLV')
.then( function (timetable) {
  console.log(timetable);
  /*
    logs: 
    [ { std: '22:19',
        etd: '',
        train: { id: '75077', line: 'RE10', name: 'Niers-Express' },
        direction: 'Düsseldorf Hbf',
        info: 'Keine Echtzeitinformationen vorhanden' } ]
})
````