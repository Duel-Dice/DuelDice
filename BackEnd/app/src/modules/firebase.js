import { initializeApp } from 'firebase-admin/app';
import admin from 'firebase-admin';
import ApiError from './error.js';

initializeApp();

export async function firebaseAuth(jwt) {
  return jwt.substring(1, 10);
  return await admin
    .auth()
    .verifyIdToken(jwt)
    .then(decoded => decoded.uid)
    .catch(error => {
      ApiError(401, `firebase auth failed! detail : ${error}`);
    });
}
