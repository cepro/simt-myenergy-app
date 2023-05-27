
# Use Supabase Kotlin lib from java source

Attempt to import and use the community lib from Java.

Because java is not well supported: https://github.com/supabase-community

## Outcome

Running the code in App.java discovered that you'd need to add dependencies for Kotlin coroutines and wrap calls in a bunch of code.

Basically it's quite clunky to do so I think it's not a good approach.

## Alternative 1

Maybe generate a client from openapi spec:
- postgREST (custom tables), available here(requires APIKEY): https://rkzgrxssutcwrauaazjz.supabase.co/rest/v1
- auth in the gotrue repo: https://github.com/supabase/gotrue/blob/master/openapi.yaml

## Alternative 2

Setup Kotlin support in our projects and use it whereever we'd like to use this or other Kotlin libraries.
