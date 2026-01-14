#!/bin/bash

docker compose run --rm watlings npm run solve 001_hello
docker compose run --rm watlings npm run solve 002_ordering
docker compose run --rm watlings npm run solve 003_export
docker compose run --rm watlings npm run solve 004_function
docker compose run --rm watlings npm run solve 005_variables
docker compose run --rm watlings npm run solve 006_numbers
docker compose run --rm watlings npm run solve 007_conditionals
docker compose run --rm watlings npm run solve 008_loops
docker compose run --rm watlings npm run solve 009_data
docker compose run --rm watlings npm run solve 010_memory
docker compose run --rm watlings npm run solve 011_host
docker compose run --rm watlings npm run solve 012_reftypes
docker compose run --rm watlings npm run solve 013_table
docker compose run --rm watlings npm run solve 014_memory_dynamic
docker compose run --rm watlings npm run solve 015_exceptions
docker compose run --rm watlings npm run solve 016_simd
docker compose run --rm watlings npm run solve 017_gc_types

docker compose run --rm watlings npm start 001_hello
docker compose run --rm watlings npm start 002_ordering
docker compose run --rm watlings npm start 003_export
docker compose run --rm watlings npm start 004_function
docker compose run --rm watlings npm start 005_variables
docker compose run --rm watlings npm start 006_numbers
docker compose run --rm watlings npm start 007_conditionals
docker compose run --rm watlings npm start 008_loops
docker compose run --rm watlings npm start 009_data
docker compose run --rm watlings npm start 010_memory
docker compose run --rm watlings npm start 011_host
docker compose run --rm watlings node --experimental-wasm-exnref exercises/011_host.mjs
docker compose run --rm watlings npm start 012_reftypes
docker compose run --rm watlings npm start 013_table
docker compose run --rm watlings npm start 014_memory_dynamic
docker compose run --rm watlings npm start 015_exceptions
docker compose run --rm watlings npm start 016_simd
docker compose run --rm watlings npm start 017_gc_types
