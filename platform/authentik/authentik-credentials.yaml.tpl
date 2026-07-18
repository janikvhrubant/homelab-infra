apiVersion: v1
kind: Secret
metadata:
  name: authentik-credentials
  namespace: authentik
stringData:
  secret-key: "REPLACE_WITH_RANDOM_50_CHAR_STRING"
  db-password: "REPLACE_WITH_RANDOM_PASSWORD"
  bootstrap-password: "REPLACE_WITH_ADMIN_PASSWORD"
  bootstrap-token: "REPLACE_WITH_RANDOM_API_TOKEN"
