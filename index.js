import express from 'express';
import client from 'prom-client'; // optional: for metrics scraping

const app = express();
const port = process.env.PORT || 3000;

// simple hello world
app.get('/', (req, res) => {
  res.send('Hello World — updated message');
});

// optional metrics endpoint for Prometheus (Task 5)
const register = client.register;
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.end(await register.metrics());
});

app.listen(port, () => {
  console.log(`Hello app listening on port ${port}`);
});
