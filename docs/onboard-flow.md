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
    participant Stripe
    
    Cepro->>Supabase: Create linked rows in `places` and `customers`<br/> in Supabase [includes customer email]
    Supabase->>Stripe: Triggers Stripe Customer record creation

    Cepro->>Customer: Send an invite either:<br/>- manually or<br/>- by Supabase trigger
    
    Customer->>App: Clicks link in invite email<br/>loads the app
    Customer->>App: Submit register form
    
    App->>Supabase: Register by email / password
    alt Email in Customers, not in auth.users
      Supabase->>Customer: password saved and confirmation sent
    else Email in Customers, already in auth.users
      Supabase->>Customer: already registered message - go to login page
    else User NOT in DB
      Supabase->>App: forbidden
    end

   Customer->>App: Clicks confirmation link in email<br/>NOTE: NOT currently supported by flutterflow integration (GDPR requirement though)
   App->>App: Authenticated, show main page
```