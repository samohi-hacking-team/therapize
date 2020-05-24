const functions = require("firebase-functions");
const admin = require("firebase-admin");
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

exports.buySessionsForLater = functions.https.onRequest(
  async (request, response) => {
    if (request.body["path"] !== null && request.body["amount"] !== null) {
      let doc = await admin
        .firestore()
        .collection("users")
        .doc("test")
        .collection("upcomingSessions")
        .doc(request.body["path"])
        .get();

      if (doc.data["amount"] !== null) {
        admin
          .firestore()
          .collection("users")
          .doc("test")
          .collection("upcomingSessions")
          .doc(request.body["path"])
          .set({
            amount: doc.data["amount"] + parseInt(request.body["amount"]),
          });
      } else {
        admin
          .firestore()
          .collection("users")
          .doc("test")
          .collection("upcomingSessions")
          .doc(request.body["path"])
          .set({
            amount: parseInt(request.body["amount"]),
          });
      }
      return response.status(200).send("Success!");
    } else {
      response.status(500).send("SMH");
    }
  }
);

exports.notifyTherapist = functions.https.onRequest((request, response) => {
  let path = request.body["path"];
  let connectionID = request.body["connectionID"];
  admin.firestore().doc(path).collection("requests").add({
    connectionID: connectionID,
  });
});
