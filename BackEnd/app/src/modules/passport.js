import firebaseJWT from 'passport-firebase-jwt';
import { UserService } from '../services/user.js';
import { firebaseAuth } from './firebase.js';

const ExtractJwt = firebaseJWT.ExtractJwt;
const JwtStrategy = firebaseJWT.Strategy;

export const JWT = new JwtStrategy(
  {
    jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
  },
  async function (jwt_payload, done) {
    try {
      const firebase_uid = await firebaseAuth(jwt_payload);
      const user = await UserService.loginUser(firebase_uid);

      done(null, user);
    } catch (error) {
      done(error);
    }
  },
);
