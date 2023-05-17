# MyEnergy - New User Onboard and Invite

This flow describes onboarding of new user. These steps must occur before a user is invited to register with the app.

Email and other details about the customer including home and meter are collected manually and added to the database.

```mermaid
sequenceDiagram
    actor Cepro
    participant Supabase
    participant Stripe
    actor Customer
    
    Cepro->>Supabase: Create User in Supabase Auth [email]
    Supabase->>Supabase: Create linked Customer record<br/>[full name, address, meter etc.]
    Supabase->>Stripe: Triggers Customer record creation in Stripe

    note over Supabase: There is an invite email sending mechansim in supabase
    Supabase->>Customer: Triggers Invite email with link to app
```