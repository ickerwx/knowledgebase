# Notes on using Splunk

## Splunk Fundamentals Training Notes

index collects data
data gets a source type
then it's normalized and stored

three components:
 - indexer
 - search head
 - forwarder

dashboard on search head

didn't complete the course

## Splunk on udemy by Adam Frisbee

### formatting timestamps

| Variable | Beschreibung       |
|----------|--------------------|
| %H/%h    | Std (24/12h)       |
| %M       | Minuten            |
| %S       | Sekunden           |
| %p       | AM/PM              |
| %A       | Full Day Name      |
| %d/%e    | Tag mit/ohne 0     |
| %B/%b    | Monatsname         |
| %m       | Monatsnummer       |
| %Y/%y    | Jahr (4/2 Ziffern) |

```
host=homework usr=* | eval timestamp=strftime(_time, "%d.%m.%Y %H:%M:%S") | table timestamp usr
```

- erstellt eine Tabelle mit Nutzernamen und Zeitstempel, formatiert vorher den Zeitstempel

### Search Modes

- Fast Modes
  - no field discovery
- Smart Mode
  - irgendwie intelligent
- Verbose Mode
  - discovers all fields it can

- Splunk detektiert key=value Paare
- die ersten 50 Paare werden links angezeigt

- Splunk hat ein Field Extraction Tool (FE)
- FE nutzt regular expressions im Hintergrund
- unter der Field list gibt es ```+ Extract New Fields``` -> öffnet FE Tool

### Transforming Commands

einige Transforming Commands:

- top
  - ```top <field>```
  - most common values
  - default 10
- rare
  - ```rare <field>```
  - returns least common
- stats
  - ```stats <function(<field>) BY <field(s)>>```
  - wendet Funktion auf Daten an

```
host="homework" state=* usr=* | stats count(usr) AS cuser BY state | sort cuser
```

```
host="homework" state=* level=critical | top state BY level
```

### Suchoperatoren

- `earliest` modifiziert den betrachteten Zeitraum

| Operator                     | Effekt                                         |
|------------------------------|------------------------------------------------|
| earliest=-h                  | looks back one hour                            |
| earliest=-2d@d latest=@s     | from two days ago up to the beginning of today |
| earliest=06/15/2018:12:30:00 | start with specified time                      |

## Splunk 4 Rookies

- Mi, 19.12. ab 13:00 Uhr
- angemeldet an AWS Instanz, admin:changeme
- über import data einfache Webserver Access Logs hinzugefügt
- Empfehlung regex101.com für field Extraction
- keine real-time Suche, sondern alle z.B. 10 Sekunden
- Suchen auf Index, sourcetype etc. eingrenzen
- pipe | head 1000 für die letzten 1000 events

- wenn DB-Abfrage nötig erscheinen, immer prüfen, ob man das nicht auch mit einem statischen export lösen kann
  - erzeugt sehr viele DB-Abfragen

```
action=purchase | timechart count span=5m partial=false | predict count future_timespan=24
```

- suche action=purchase
- `predict` interpoliert aus vorangegangenen Datensätzen
  - was genau tut `partial`?

## Phantom 4 Rookies

- 15.01.19, ab 13:00 Uhr
- credentials von Splunk4R gehen nicht (admin:changeme)
  - admin:password

- Phantom: anlegen von Playbooks
- SOAR, Sec Orchestration, Automation, Response

- VM: https://ec2-34-246-191-199.eu-west-1.compute.amazonaws.com/login?next=/

- Phantom Cluster, davor und danach Load Balancer (unklar, ob die zwei Load Balancer das selbe System sein sollen)
  - cluster nutzt Postgres DB, nginx und SplunkSearch

- Load Balancer nimmt Meldungen aus Endpoint Security oder SIEM an, außerdem auch externe Quellen

- Apps verarbeiten Daten

- Phantom macht ebenfalls eine Art Datennormalisierung, verarbeitet 'notable events'


user1@coffee4y.com
P4R_01@
coffee4y.com

- Playbooks > New Playbook
- Name vergeben, Klick auf grüne Bubble neben START

- Playbook testen
  - am besten im Playbook Debugger
  - Debugger geht nicht auf die Container/d-Limitierung
  - Scheint auch ein anstrengendes Lizenzmodell zu haben, man zahlt für Events pro Tag

tags: blueteam splunk training phantom
