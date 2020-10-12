# ELK-related stuff

## Apache-Logparser für logstash

```
input {
	file {
		path => "/path/to/file"
		start_position => beginning
	}
}

filter {
    grok {
        match => { "message" => "%{COMBINEDAPACHELOG}"}
    }
    date {
        match => ["timestamp", "dd/MMM/yyyy:HH:mm:ss Z"]
    }
}

output {
    elasticsearch {
        protocol => "http"
	index => "indexname"
    }
}
```

## elasticsearch queries

```sh
curl -XDELETE 'localhost:9200/_all'
curl -XGET localhost:9200/indexname/_count?q=*
```

tags: #blueteam #elk #elasticsearch #logstash 
