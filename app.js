const express = require('express');
const app = express();
const resRoute = require('./routes/resRoute.js');
const usersRoute = require('./routes/usersRoute.js');
// Define a route for the homepage
app.get('/', (req, res) => {
     res.send('Hello, world!');
});

app.use('/res', resRoute);
app.use('/users', usersRoute);
// Start the server
const port = 3000;
app.listen(port, () => {
     console.log(`Server listening on port ${port}`);
});
