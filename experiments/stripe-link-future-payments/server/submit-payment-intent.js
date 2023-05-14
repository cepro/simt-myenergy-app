require("dotenv").config({ path: "./.env" });

const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);

const main = async () => {
  try {
    await stripe.paymentIntents.create(
      {
        amount: 1200,
        description: "Meter Top Up for Hatch",
        currency: "gbp",
        capture_method: "automatic",
        payment_method_types: ["link"],
        customer: "cus_NswEeTMKsm3fTV",
        payment_method: "pm_1N7YBIDWx0N1Jycd0Df6QuSv",
        off_session: "true",
        confirm: "true",
        return_url: "http://localhost:4242/link-success",
      }
      // automatic_payment_methods: {enabled: true},
    );
  } catch (err) {
    // Error code will be authentication_required if authentication is needed
    console.log("Error code is: ", err.code);
    const paymentIntentRetrieved = await stripe.paymentIntents.retrieve(
      err.raw.payment_intent.id
    );
    console.log("PI retrieved: ", paymentIntentRetrieved.id);
  }
};

main();
