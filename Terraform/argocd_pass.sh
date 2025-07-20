#!/bin/bash

PASSWORD=$(kubectl get secret argocd-initial-admin-secret \
  -n argocd \
  -o jsonpath="{.data.password}" | base64 --decode)

jq -n --arg password "$PASSWORD" '{"password":$password}'