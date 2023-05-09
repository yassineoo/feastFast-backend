const prisma = require('../prisma/dbConnection');

// Create a new order
async function createOrder(req, res) {
     try {
          const {
               user_id,
               restaurant_id,
               delivery_address,
               delivery_notes,
               order_items,
          } = req.body;

          // Create the order in the database
          const order = await prisma.orders.create({
               data: {
                    user_id,
                    restaurant_id,
                    delivery_address,
                    delivery_notes,
                    order_items: {
                         create: order_items,
                    },
               },
               include: {
                    order_items: true,
               },
          });

          res.status(201).json(order);
     } catch (error) {
          console.error(error);
          res.status(500).json({ message: 'Error creating order' });
     }
}

// Get all orders for a user
async function getOrdersByUserId(req, res) {
     try {
          const { userId } = req.params;

          const orders = await prisma.orders.findMany({
               where: {
                    user_id: userId,
               },
               include: {
                    order_items: {
                         include: {
                              menu_item: true,
                         },
                    },
                    restaurant: true,
               },
          });

          res.json(orders);
     } catch (error) {
          console.error(error);
          res.status(500).json({ message: 'Error getting orders by user id' });
     }
}
/*
// Get all orders for a restaurant
async function getOrdersByRestaurantId(req, res) {
     try {
          const { restaurantId } = req.params;

          const orders = await prisma.orders.findMany({
               where: {
                    restaurant_id: restaurantId,
               },
               include: {
                    order_items: {
                         include: {
                              menu_item: true,
                         },
                    },
                    user: true,
               },
          });

          res.json(orders);
     } catch (error) {
          console.error(error);
          res.status(500).json({
               message: 'Error getting orders by restaurant id',
          });
     }
}
*/

async function updateOrder(req, res) {
     const { id } = req.params;
     const { order_status } = req.body;

     try {
          const updatedOrder = await prisma.orders.update({
               where: { id: parseInt(id) },
               data: { order_status },
          });
          res.json(updatedOrder);
     } catch (error) {
          console.error(error);
          res.status(500).send('Error updating order');
     }
}

module.exports = {
     createOrder,
     getOrdersByUserId,
     updateOrder,
};
