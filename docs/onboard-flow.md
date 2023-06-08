# MyEnergy - New User Onboard

This flow describes onboarding of new user.

Email and other details about the customer including home and meter are collected manually and added to the database.

Then the user can regsister with a password of their choosing.

```mermaid
sequenceDiagram
    actor Cepro
    actor Customer
    participant App as Flutter App
    participant Supabase
    participant BillingSvc as simt-j-billingstripe 
    participant Stripe
    
    Cepro->>Supabase: Create linked rows in `properties` and `customers`<br/> in Supabase [includes customer email]
    Cepro->>Customer: Send an invite either:<br/>- manually or<br/>- by Supabase trigger
    
    Customer->>App: Clicks link in invite email
    App->>Customer: loads the app
    Customer->>App: Submit register form
    
    App->>Supabase: Register by email / password

    Supabase->>Supabase: trigger customer_registration_trigger executed<br/>- checks email in customers with status 'pending',<br/>reverts if not (see below)

    alt Email in auth.users already
      Supabase->>Customer: currently supabase just issues a token as if logging in, but the UI isn't handing this yet
    else Email in customers with status 'pending'
      Supabase->>Supabase: Creates `auth.users` record<br/>and set customers.status to 'live'
      Supabase->>BillingSvc: supabase db webhook (trigger under the hood)<br/>POST /customers/fromSupabase
      BillingSvc->>Stripe: create stripe customer with given email
      Supabase->>Customer: send confirmation email
    else User NOT in customers
      Supabase->>App: error sent to user
    end

   App->>App: Authenticated, show main page
```