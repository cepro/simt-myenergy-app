require("dotenv").config({ path: "./.env" });

const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);

const main = async () => {
  try {
    await stripe.paymentIntents.create(
      {
        amount: 1501,
        description: "Meter Top Up Secure 3d 2. Ref: 2",
        currency: "gbp",
        capture_method: "automatic",
        payment_method_types: [
          // "link" - when non-secure or 3d secure in test that failed ...
          "card" // when 3d secure card ending in 3155 in test mode
        ],
        customer: "cus_NuOOndKIbOWYh8",
        payment_method: "pm_1N99klDWx0N1JycdlfJmMJYE",
        off_session: "true",
        confirm: "true",
        return_url: "http://localhost:4242/link-success",
      }
      // automatic_payment_methods: {enabled: true},
    );
  } catch (err) {
    // Error code will be authentication_required if authentication is needed
    console.log(`Error: ${JSON.stringify(err, null, 2)}`);
    const paymentIntentRetrieved = await stripe.paymentIntents.retrieve(
      err.raw.payment_intent.id
    );
    console.log("PI retrieved: ", paymentIntentRetrieved.id);
  }
};

main();
