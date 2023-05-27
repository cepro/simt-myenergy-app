
# Use Supabase Kotlin lib from java source

Attempt to import and use the community lib from Java.

Because java is not well supported: https://github.com/supabase-community

## Outcome

Running the code in App.java discovered that you'd need to add dependencies for Kotlin coroutines and wrap calls in a bunch of code.

Basically it's quite clunky to do so I think it's not a good approach.

## Alternative

Maybe generate a client from openapi spec or just write a simple one that makes the REST calls as needed.