#!/bin/bash

PASSWORD=$(kubectl get secret prometheus-grafana \
  -n monitoring \
  -o jsonpath="{.data.admin-password}" | base64 --decode)

jq -n --arg password "$PASSWORD" '{"password":$password}'
