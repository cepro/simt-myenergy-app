
import { serve } from "https://deno.land/std@0.168.0/http/server.ts"

console.log("Hello from Functions!")

serve(async (req) => {
    const { name } = await req.json()
    const data = {
        message: `Hello ${name}!`,
    }

    console.log(`Request body: ${req.json}`)

    for (const [key, value] of req.headers.entries()) {
        console.log(`${key}: ${value}`);
    }

    return new Response(
        JSON.stringify(data),
        { headers: { "Content-Type": "application/json" } },
    )
})
