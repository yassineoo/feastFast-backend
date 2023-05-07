const express = require('express');
const app = express();
const resRoute = require('./routes/resRoute.js');

// Define a route for the homepage
app.get('/', (req, res) => {
     res.send('Hello, world!');
});

app.use('/res', resRoute);
// Start the server
const port = 3000;
app.listen(port, () => {
     console.log(`Server listening on port ${port}`);
});
