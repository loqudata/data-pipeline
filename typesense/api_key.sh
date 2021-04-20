#!/bin/bash

curl 'http://localhost:8108/keys' -X POST -H "X-TYPESENSE-API-KEY: ${TYPESENSE_API_KEY}" \
    -H 'Content-Type: application/json' \
    -d '{"description":"Search and get key","actions": ["documents:search", "documents:get"], "collections": ["*"]}'
