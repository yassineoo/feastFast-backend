const prisma = require('../prisma/dbConnection');
const { format } = require('date-fns');
// Create a new order
async function createOrder(req, res) {
     
          const data  = req.body;

          // Create the order in the database
          const date = new Date(); // Replace this with your actual date value
          const time = new Date(); // Replace this with your actual time value
        
          const formattedDate = format(date, 'yyyy-MM-dd');
          const formattedTime = format(time, 'HH:mm:ss');
        
          try {
            const createdOrder = await prisma.orders.create({
              data: {...data,
                date: new Date(),
                time: new Date(),
                // other order data...
              },
            });

          res.status(201).json(createdOrder);
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
                    user_id: Number(userId),
               },
                    orderBy: {
                         date: 'desc',
                    },
          });

          return res.json(orders);
     } catch (error) {
          console.error(error);
          return res.status(500).json({ message: 'Error getting orders by user id'+error });
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
