const express = require('express');
const router = express.Router();
const restaurantController = require('../controllers/resController');

// Route to get all restaurants
router.get('/', restaurantController.getAllRestaurants);

// Route to get a specific restaurant by ID
router.get('/:id', restaurantController.getRestaurantById);

module.exports = router;
