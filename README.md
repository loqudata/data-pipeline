# Loqu Data Pipeline

This repository downloads, converts, and loads metadata from DBNomics into the graph database, and links it to public knowledge graphs.

**NOTE:** This repo still contains many hard-coded directories in the scripts and tools. Eventually those will be updated, but until then it may be difficult to use without modifications. Search for `/mnt/data` to replace if necessary.

The `docker-compose.yml` file has all of the services required to serve the Loqu backend: Virtuoso, LIMES, TypeSense, the Loqu API container (which you should build from that repository), and a simple reverse proxy that loadbalances requests to the Search and API services via the Host header.

## Pipeline steps

Follow the steps below to get the source data and create a Loqu backend:

- Download and transform the source data from DBNomics
  - Download the data with `./scraper/main.go` as `.json` files
  - Run `./converter/run.mjs` to convert to JSON-LD
  - Run `./jsonld2nt/main.go` to convert to N-Triples
  - (optional) validate a subset of your data using the Data Cube integrity constraints with `run.sh` in `integrity-constraints`
- Run `docker-compose up` to start the backend. Make sure you have a `.env` file that sets the required variables (eg location of data from previous step)
- Load data into the database
  - Docker exec into Virtuoso database and run `/scripts/load.sh`
- Create links between concepts
  - Write your LIMES configs in the `limes` folder, then submit them with `submit.sh`
  - TODO: store theses in a better place (eg cloud object storage)
