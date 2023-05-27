package com.cepro.jwtencoder;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.HashMap;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.env.Environment;
import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jose.JWSSigner;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;

// @formatter:off
/**
 * Generate and encode JWTs as issued by Supabase.
 * 
 * When decoded Supabase JWTs looks like this:
 * 
 * {
 *    "aud": "authenticated",
 *    "exp": 1685210002,
 *    "sub": "b4cf2b22-cc04-4c86-a910-c601cfdfc244",
 *    "email": "hatch@tuta.io",
 *    "phone": "",
 *    "app_metadata": {
 *      "provider": "email",
 *      "providers": [
 *        "email"
 *      ]
 *    },
 *    "user_metadata": {},
 *    "role": "authenticated",
 *    "aal": "aal1",
 *    "amr": [
 *      {
 *        "method": "password",
 *        "timestamp": 1685206402
 *      }
 *    ],
 *    "session_id": "866d8202-751c-4c6d-888a-5fac2c436e7b"
 *  }
 */
// @formatter:on
@SpringBootApplication
public class JwtEncoderApplication {
    public static final int DEFAULT_EXPIRY_DAYS = 30;

    public static JWTClaimsSet buildClaims() {
        return new JWTClaimsSet.Builder()
                .audience("authenticated")
                .subject("b4cf2b22-cc04-4c86-a910-c601cfdfc244")
                .expirationTime(Date.from(Instant.now().plus(DEFAULT_EXPIRY_DAYS, ChronoUnit.DAYS)))
                .claim("role", "authenticated")
                .claim("email", "name@test.xyz")
                .claim("user_metadata", new HashMap<>())
                .build();
    }

    public static void main(String[] args) throws Exception {
        Environment environment =
                SpringApplication.run(JwtEncoderApplication.class, args).getEnvironment();
        String jwtSecretString = environment.getProperty("jwt.secret");

        JWSSigner signer = new MACSigner(jwtSecretString.getBytes());

        // Prepare JWT with claims set
        JWTClaimsSet claimsSet = buildClaims();

        SignedJWT signedJWT = new SignedJWT(new JWSHeader(JWSAlgorithm.HS256), claimsSet);
        signedJWT.sign(signer);

        String jwtString = signedJWT.serialize();
        System.out.println(jwtString);
    }

}
