const  express =require ("express");
const  admin =require("firebase-admin");
const fcm = require("fcm-notification");
const serviceAccount = require('../feastfast-387618-firebase-adminsdk-ynpc4-eb0b4c534b.json');
const prisma = require("../prisma/dbConnection");

const notificationRouter = express.Router();
const certPath = admin.credential.cert(serviceAccount);
const FCM = new fcm(certPath);

notificationRouter.post("/send", async (request, response, next) => {
  try {
    if (request.body.status == "Completed") {
     await prisma.orders.update({where:{id:request.body.orderId} ,data:{order_status:"Completed"}})
    }
    const message = {
      notification: {
        title: "Hello Drear you!",
        body: `Your command number ${request.body.orderId} is ${request.body.status}!`,
      },
      data: {
        test: "test",
      },
      token: request.body.fcm_token,
    };

    FCM.send(message, (err, res) => {
      if (err) {
        return response.status(500).send({
          message: err.message,
        });
      } else {
        return response.status(200).send({
          message: "Notification sent",
        });
      }
    });
  } catch (error) {
    next(error);
  }
});

module.exports= notificationRouter;