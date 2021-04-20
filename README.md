# Loqu Data Pipeline

This repository downloads, converts, and loads metadata from DBNomics into the graph database, and links it to public knowledge graphs.

**NOTE:** This repo still contains many hard-coded directories in the scripts and tools. Eventually those will be updated, but until then it may be difficult to use without modifications. Search for `/mnt/data` to replace if necessary.

## Pipeline steps

1. Download the data with `./scraper/main.go` as `.json` files
2. Run `./converter/run.mjs` to convert to JSON-LD
3. Run `./jsonld2nt/main.go` to convert to N-Triples
4. Start database and LIMES with `docker-compose up`. Make sure you have a `.env` file that sets the required variables.
5. Docker exec into the database and run `/scripts/load.sh`
6. (optional) run the Data Cube integrity constraints with `run.sh` in `integrity-constraints`
7. Write your LIMES configs in the `limes` folder, then submit them with `submit.sh`

## Running with Docker Compose

The `docker-compose.yml` configuration has all of the services required: Virtuoso, LIMES, TypeSense, the Loqu API container (which you should build from that repository), and a simple reverse proxy that loadbalances requests to the Search and API services via the Host header.
