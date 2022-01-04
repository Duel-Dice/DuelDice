import { initializeApp } from 'firebase-admin/app';
import admin from 'firebase-admin';
import ApiError from './error.js';

initializeApp();

function getRandomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min)) + min;
}

export async function firebaseAuth(jwt) {
  let sum = '';

  for (let c of jwt) sum += c.charCodeAt(0) + 500;
  return sum.substring(0, 20);
  return await admin
    .auth()
    .verifyIdToken(jwt)
    .then(decoded => decoded.uid)
    .catch(error => {
      ApiError(401, `firebase auth failed! detail : ${error}`);
    });
}
