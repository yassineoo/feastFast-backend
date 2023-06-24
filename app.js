const express = require('express');
const app = express();
const resRoute = require('./routes/resRoute.js');
const usersRoute = require('./routes/usersRoute.js');
const ordersRoute = require('./routes/orderRoutes.js');
const notificationRouter = require("./routes/notifRoute.js");
//const cors = require('cors');
app.use(express.static('public'))
// Define a route for the homepage
app.use(express.static('public'));
app.get('/', (req, res) => {
	res.send('Hello, world!');
});
app.use(express.json());

app.use('/res', resRoute);
app.use('/users', usersRoute);
app.use('/orders', ordersRoute);
app.use("/notif", notificationRouter);
//Start the server 
const port = 3000;
app.listen(port, () => {
	console.log(`Server listening on port ${port}`);
});
