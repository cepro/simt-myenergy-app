document.addEventListener("DOMContentLoaded", async (e) => {
  const stripe = Stripe(
    "pk_test_51N73HiDWx0N1Jycd8luQM1g6cO5qHvgdApMe0u84CY3bEoDXvE86LlfhNaHCYrAj0XLsU0MRV0D304jFylHn7TIG00uJYgudFJ"
  );

  const clientSecret = `seti_1N7AS1DWx0N1JycdOksNOOyG_secret_NswKM96GFzGJRjIfGW6L6ZvLqznQEF9`;

  // Customize the appearance of Elements using the Appearance API.
  const appearance = {
    /* ... */
  };

  // Create an elements group from the Stripe instance passing in the clientSecret and, optionally, appearance.
  const elements = stripe.elements({ clientSecret, appearance });

  // Passing in the email is required for this integration. The other fields are optional.
  // This is useful if you want to prefill consumer information to simplify the costumer experience.
  const paymentElement = elements.create("payment", {
    defaultValues: {
      billingDetails: {
        email: "asahi@tutanota.com",
        //   name: 'John Doe',
        //   phone: '888-888-8888',
      },
    },
  });

  // Mount the Elements to their corresponding DOM node
  paymentElement.mount("#payment-element");

  const form = document.getElementById("payment-form");

  form.addEventListener("submit", async (event) => {
    event.preventDefault();

    const { error } = await stripe.confirmSetup({
      elements,
      confirmParams: {
        return_url: "http://localhost:4242/link-success",
      },
    });

    if (error) {
      // Show error to your customer (for example, payment details incomplete)
      console.log(error.message);
    } else {
      // Your customer will be redirected to your `return_url`. For some payment
      // methods like iDEAL, your customer will be redirected to an intermediate
      // site first to authorize the payment, then redirected to the `return_url`.
      console.log(`success - customer will be redirected to out callback`);
    }
  });
});
