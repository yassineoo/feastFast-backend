const {getCmdsByUserId, getCmdById, postCmdFromUser, updateCmd, deleteCmd } = require("../models/comandeService")
const {authentif, postUser, getUserDetailsById, setUserToken} = require("../models/userService")

// fcm
const admin = require('firebase-admin');

// Initialize the Firebase app with the service account key
const serviceAccount = require('../feastfast-387618-firebase-adminsdk-ynpc4-eb0b4c534b.json');
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
});

  const notifyUserOfCommandState =  async (req, res) => { 
    try {
      var {IdCmd} =  req.params;
      IdCmd = parseInt( IdCmd );
      const { etat } = req.body;

      console.log("IdCmd, etat:", IdCmd,etat );

      // Get the command details
      const [command] = await getCmdById( IdCmd ) ;
      if (!command) {
            throw new Error(`Command with id ${IdCmd} not found`);
          }
        console.log("command get id avec suces= ", command, "command.IdUser:", command.IdUser);
      // Get the user details
      const [user] = await getUserDetailsById( command.IdUser );
      if (!user) {
        throw new Error(`User with id ${command.IdUser} not found`);
      }
      console.log("user get id avec suces");


      // Get the user's FCM token
      const token = user.tokenDevice;
      if (!token) {
        throw new Error(`FCM token not found for user with id ${user.id}`);
      }
  
      // Prepare the notification message
      const message = {
        token: token,
        notification: {
          title: `Order id  ${IdCmd} State Change`,
          body: `${etat}`,
        },
      };
  
      //changer etat
      await updateCmd(IdCmd, etat)
      console.log("updateCmd");
      // Send the notification
      await sendNotification(message);
      return "sucees";
    
    } catch (error) {
      console.log(error);
      return null;
    }
  }


    const sendNotification =  async ( message ) => { 
    
    await admin.messaging().send(message).then((response) => {
      console.log('Successfully sent message:', response);
    })
    .catch((error) => {
      console.error('Error sending message:', error);
      if (error.code === 'messaging/invalid-registration-token') {
        console.error('Invalid registration token. Check that the token is correct and not expired.');
      }
    });
      
  }

  

module.exports = {
  notifyUserOfCommandState
};