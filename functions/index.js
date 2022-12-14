const functions = require('firebase-functions');

  exports.makeUppercase = functions.database.ref('/messages/{pushId}/original')
      .onCreate((snapshot, context) => {
        const original = snapshot.val();
        console.log('Uppercasing', context.params.pushId, original);
        const uppercase = original.toUpperCase();
        return snapshot.ref.parent.child('uppercase').set(uppercase);
      });
  