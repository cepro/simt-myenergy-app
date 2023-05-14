const express = require('express');
const cookieParser = require('cookie-parser');

const app = express();

require('dotenv').config({ path: './.env' });

require('stripe')(process.env.STRIPE_SECRET_KEY, {
  appInfo: { // For sample support and debugging, not required for production:
    name: "stripe-samples/link-with-stripe",
    version: "0.0.1",
    url: "https://github.com/stripe-samples/link-with-stripe",
  }
});

app.use(express.static(process.env.STATIC_DIR));
app.use(cookieParser());

app.get('/link-success', async (req, res) => {
  console.log(JSON.stringify(req.rawBody))
  res.send(req.rawBody);
});

app.listen(4242, () => console.log(`Node server listening at http://localhost:4242`));
