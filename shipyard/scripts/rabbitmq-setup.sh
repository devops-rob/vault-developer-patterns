#!/bin/sh

# create exchange
curl -i -u guest:guest -H "content-type:application/json" \
    -XPUT -d'{"type":"fanout","durable":true}' \
    http://localhost:15672/api/exchanges/%2f/owasp.devslop
    
# create queue
curl -i -u guest:guest -H "content-type:application/json" \
    -XPUT -d'{"durable":true,"arguments":{"x-dead-letter-exchange":"", "x-dead-letter-routing-key": "queue.dead-letter"}}' \
    http://localhost:15672/api/queues/%2f/devopsrob

# create queue related dead letter queue
curl -i -u guest:guest -H "content-type:application/json" \
    -XPUT -d'{"durable":true,"arguments":{}}' \
    http://localhost:15672/api/queues/%2f/queue.dead-letter
    
# create binding
curl -i -u guest:guest -H "content-type:application/json" \
    -XPOST -d'{"routing_key":"devopsrob","arguments":{}}' \
    http://localhost:15672/api/bindings/%2f/e/owasp.devslop/q/devopsrob