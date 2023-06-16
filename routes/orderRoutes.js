const express = require('express');
const router = express.Router();

const orderController = require('../controllers/orderController');

// Order routes
router.post('/creatOrder', orderController.createOrder);
router.get('/users/:userId/orders', orderController.getOrdersByUserId);
//router.get('/users/:userId/orders/:id', getOrderById);
//router.post('/updateOrder/:id', updateOrder);
//router.delete('/users/:userId/orders/:id', deleteOrder);

module.exports = router;
