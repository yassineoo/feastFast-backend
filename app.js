const express = require('express');
const app = express();
const resRoute = require('./routes/resRoute.js');
const usersRoute = require('./routes/usersRoute.js');
app.use(express.static('public'))
// Define a route for the homepage
app.use(express.static('public'));
app.get('/', (req, res) => {
	res.send('Hello, world!');
});
app.use(express.json());

app.use('/res', resRoute);
app.use('/users', usersRoute);
//Start the server 
const port = 3000;
app.listen(port, () => {
	console.log(`Server listening on port ${port}`);
});
