#!/bin/bash

DB_URL="http://localhost:8108"
TYPESENSE_API_KEY="aaeff9df"



for schema in $(dirname "$0")/*.json; do
    # httpie automatically sets content type?
    http POST "$DB_URL/collections" "X-TYPESENSE-API-KEY: ${TYPESENSE_API_KEY}" < $schema
done
