#!/bin/bash

# Si le premier argument est vide, afficher un message d'erreur et quitter le script
if [ -z "$1" ]; then
  echo "Usage: ./bulk_ingest.sh <index_name> [num_files]"
  echo "       ./bulk_ingest.sh <index_name>"
  echo "        |---- Ingests all .ndjson files in the current directory"
  echo "Options:"
  echo "  <index_name>: Name of the Elasticsearch index to ingest data into"
  echo "  <num_files>: Number of .ndjson files to ingest."
  echo "               Default: ingest all files in the current directory"
  exit 1
fi

# Si le deuxième argument est fourni, utiliser sa valeur comme limite
if [ -n "$2" ]; then
  limit="$2"
else
  # Sinon, utiliser le nombre de fichiers .ndjson dans le répertoire courant comme limite
  limit=$(ls -1 *.ndjson | wc -l)
fi

# Afficher le nombre maximum de fichiers qui seront traités pour l'index spécifié
echo "Ingesting data into index '$1' from a maximum of $limit .ndjson files"

# Initialiser la variable i à 1
i=1

# Parcourir chaque fichier .ndjson dans le répertoire courant
for file in *.ndjson; do
  # Si i est supérieur à la limite, sortir de la boucle
  if [ "$i" -gt "$limit" ]; then
    break
  fi

  # Envoyer une requête POST Elasticsearch pour indexer les données du fichier courant dans l'index spécifié
  curl -XPOST "localhost:9200/$1/_bulk" -H "Content-Type: application/x-ndjson" --data-binary "@$file"

  # Incrémenter i de 1
  i=$((i+1))
done
https://9200-xeonalphakp-elasticproj-jod1uh2loml.ws-eu95.gitpod.io
curl -X POST "https://9200-xeonalphakp-elasticproj-jod1uh2loml.ws-eu95.gitpod.io/_bulk?pretty" -H 'Content-Type: application/json' -d'
{ "index" : { "_index" : "test2", "_id" : "1" } }
{ "field1" : "value1" }
{ "delete" : { "_index" : "test2", "_id" : "2" } }
{ "create" : { "_index" : "test2", "_id" : "3" } }
{ "field1" : "value3" }
{ "update" : {"_id" : "1", "_index" : "test2"} }
{ "doc" : {"field2" : "value2"} }
'