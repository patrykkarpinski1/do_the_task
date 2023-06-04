const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const queueCollection = admin.firestore().collection("queue");

exports.scheduleNotification = functions.firestore
    .document("users/{userId}/tasks/{taskId}")
    .onCreate(async (snapshot, context) => {
      try {
        const documentData = snapshot.data();
        const notificationTime = documentData.date.toDate();
        const currentTime = new Date();

        if (currentTime <= new Date(notificationTime.getTime() -
          24 * 60 * 60 * 1000)) {
          await queueCollection.add({
            categoryId: documentData.category_id,
            text: documentData.text,
            userId: context.params.userId,
            taskId: context.params.taskId,
            executeAt: admin.firestore.Timestamp.
                fromMillis(notificationTime.getTime() - 24 * 60 * 60 * 1000),
            notificationType: "24-hour",
          });
        }

        if (currentTime <= new Date(notificationTime.getTime() -
          60 * 60 * 1000)) {
          await queueCollection.add({
            categoryId: documentData.category_id,
            text: documentData.text,
            userId: context.params.userId,
            taskId: context.params.taskId,
            executeAt: admin.firestore.Timestamp.
                fromMillis(notificationTime.getTime() - 60 * 60 * 1000),
            notificationType: "1-hour",
          });
        }

        if (notificationTime > currentTime) {
          const delayInMillis = notificationTime.
              getTime() - currentTime.getTime();
          const notificationDelay = delayInMillis > 0 ? delayInMillis : 0;

          await queueCollection.add({
            categoryId: documentData.category_id,
            text: documentData.text,
            userId: context.params.userId,
            taskId: context.params.taskId,
            executeAt: admin.firestore.Timestamp.
                fromMillis(currentTime.getTime() + notificationDelay),
            notificationType: "task",
          });
        }
      } catch (error) {
        console.error("Error in scheduleNotification function:", error);
        throw error;
      }
    });

exports.processQueue = functions.runWith({maxInstances: 1})
    .pubsub.schedule("every 1 minutes").onRun(async () => {
      const tasksSnapshot = await queueCollection
          .where("executeAt", "<=", admin.firestore.Timestamp.now())
          .get();

      for (const doc of Array.from(tasksSnapshot.docs)) {
        const task = doc.data();

        const userSnapshot = await admin.firestore()
            .collection("users")
            .doc(task.userId)
            .get();

        const user = userSnapshot.data();

        if (user && user.notificationsEnabled) {
          const categoryDoc = await admin.firestore()
              .doc(`categories/${task.categoryId}`).get();
          const categoryName = categoryDoc.data().title;

          let title;
          switch (task.notificationType) {
            case "24-hour":
              title = "Reminder: You have a task due in 24 hours";
              break;
            case "1-hour":
              title = "Reminder: You have a task due in 1 hour";
              break;
            case "task":
              title = "Reminder of the task";
              break;
          }

          const message = {
            notification: {
              title: title,
              body: categoryName,
            },
            data: {
              category_id: task.categoryId,
              text: task.text,
              task_id: task.taskId,
            },
          };

          await admin.messaging().sendToTopic(`task_${task.userId}`, message);
        }
        await doc.ref.delete();
      }
    });


exports.deleteScheduledNotification = functions.firestore
    .document("users/{userId}/tasks/{taskId}")
    .onDelete(async (snapshot, context) => {
      try {
        const taskId = context.params.taskId;

        const taskSnapshot = await queueCollection
            .where("taskId", "==", taskId).get();

        if (!taskSnapshot.empty) {
          for (const doc of Array.from(taskSnapshot.docs)) {
            await doc.ref.delete();
          }
        }
      } catch (error) {
        console.error("Error in deleteScheduledNotification function:", error);
        throw error;
      }
    });


/**
 * Cloud Function to clean up user data when the user account is deleted.
 *
 * @param {Object} user - The user object provided by the onDelete trigger.
 * @return  {Promise} - A promise that resolves
 * when all user data has been deleted.
 */
exports.cleanupUserData = functions.auth.user().onDelete((user) => {
  const uid = user.uid;

  const defaultProfileImageRef = `users/${uid}/profil_images`;
  const photoNoteRef = `users/${uid}/photo_note`;

  const firestore = admin.firestore();

  const collections = [
    firestore.collection("users").doc(uid).collection("tasks"),
    firestore.collection("users").doc(uid).collection("notepad"),
    firestore.collection("users").doc(uid).collection("photo_note"),
  ];

  const promises = collections.map((collection) =>
    deleteCollection(firestore, collection));

  promises.push(deleteFiles(defaultProfileImageRef));
  promises.push(deleteFiles(photoNoteRef));
  promises.push(firestore.collection("users").doc(uid).delete());

  return Promise.all(promises);
});

/**
 * Deletes all documents in a Firestore collection.
 *
 * @param {Object} firestore - The Firestore instance.
 * @param {Object} collection - The Firestore collection to delete.
 * @return  {Promise} - A promise that resolves when all
 * documents in the collection have been deleted.
 */
function deleteCollection(firestore, collection) {
  return collection.get()
      .then((snapshot) => {
        const batch = firestore.batch();
        snapshot.docs.forEach((doc) => {
          batch.delete(doc.ref);
        });
        return batch.commit();
      });
}

/**
 * Deletes all files in a Firebase Storage folder.
 *
 * @param {string} folder - The folder in Firebase Storage to delete.
 * @return  {Promise} - A promise that resolves when
 * all files in the folder have been deleted.
 */
function deleteFiles(folder) {
  const bucket = admin.storage().bucket();

  return bucket.getFiles({prefix: folder})
      .then((data) => {
        const files = data[0];
        const deleteOps = files.map((file) => file.delete());
        return Promise.all(deleteOps);
      })
      .catch((err) => console.log("Failed to delete files:", err));
}


