const  express =require ("express");
const sendPushNotifications = require("../controllers/notifService");

const notificationRouter = express.Router();

notificationRouter.post("/send", sendPushNotifications);

module.exports= notificationRouter;