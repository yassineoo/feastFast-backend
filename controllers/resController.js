const prisma = require('../prisma/dbConnection');
// Controller function to get all restaurants
const getAllRestaurants = async (req, res) => {
     try {
          const restaurants = await prisma.restaurants.findMany();
          res.status(200).json(restaurants);
     } catch (err) {
          res.status(500).json({ error: err.message });
     }
};

// Controller function to get a specific restaurant by ID
const getRestaurantById = async (req, res) => {
     try {
          const { id } = req.params;
          const restaurant = await prisma.restaurants.findUnique({
               where: { id: parseInt(id) },
          });
          if (!restaurant) {
               return res
                    .status(404)
                    .json({ error: `Restaurant with ID ${id} not found` });
          }
          res.status(200).json(restaurant);
     } catch (err) {
          res.status(500).json({ error: err.message });
     }
};

// Controller function to get a specific restaurant Menu by ID
const getRestaurantMenuById = async (req, res) => {
     try {
          const { id } = req.params;
          const restaurant = await prisma.menuitems.findMany({
               where: { restaurant_id: parseInt(id) },
          });
          if (!restaurant) {
               return res
                    .status(404)
                    .json({ error: `Restaurant with ID ${id} not found` });
          }
          res.status(200).json(restaurant);
     } catch (err) {
          res.status(500).json({ error: err.message });
     }
};

module.exports = {
     getAllRestaurants,
     getRestaurantById,
     getRestaurantMenuById,
};
