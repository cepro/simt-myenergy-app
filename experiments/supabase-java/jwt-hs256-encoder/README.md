# jwt-hs256-encoder

Generate, sign and encode JWT tokens using the HS256 algorithm as used by Supabase.

See JwtEncoderApplication for details and an example of the JSON inside a supabase token.

Modify the properties in JwtEncoderApplication to customize the token.

## JWT Secret Setup

Copy src/main/resources/secrets.sample.properties to src/main/resources/secrets.properties and either:
- insert your Supabase JWT secret there or
- generate one for testing (see instructions in the file) 
