const express = require('express');
const router = express.Router();
const restaurantController = require('../controllers/resController');

// Route to get all restaurants
router.get('/:idUser', restaurantController.getAllRestaurants);
router.get('/fav/:idUser', restaurantController.getFavriteRestaurants);

/*
// Menu Item routes
router.post('/restaurants/:restaurantId/menuitems', createMenuItem);
router.get('/restaurants/:restaurantId/menuitems', getMenuItemsByRestaurantId);
router.put('/restaurants/:restaurantId/menuitems/:id', updateMenuItem);
router.delete('/restaurants/:restaurantId/menuitems/:id', deleteMenuItem);

// Rating routes
router.post('/restaurants/:restaurantId/ratings', createRating);
router.get('/restaurants/:restaurantId/ratings', getRatingsByRestaurantId);
router.put('/restaurants/:restaurantId/ratings/:id', updateRating);
router.delete('/restaurants/:restaurantId/ratings/:id', deleteRating);
*/
// Route to get a specific restaurant by ID
router.get('/:id', restaurantController.getRestaurantById);

router.get('/:id/menu', restaurantController.getRestaurantMenuById);

module.exports = router;
