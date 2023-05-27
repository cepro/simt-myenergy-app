curl -X POST \
  https://generator3.swagger.io/api/generate \
  --output genapi.zip \
  -H 'content-type: application/json' \
  -d '{
  "specURL" : "https://raw.githubusercontent.com/supabase/gotrue/master/openapi.yaml",
  "lang" : "java",
  "type" : "CLIENT",
  "codegenVersion" : "V3"
}'

