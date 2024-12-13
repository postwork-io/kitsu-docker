#!/bin/bash
zou init-db
zou init-data
zou reset-search-index
zou create-admin --password $2 $1
