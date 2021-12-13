import passportJWT from 'passport-jwt';
import config from '../config/index.js';
import { UserService } from '../services/user.js';

const ExtractJwt = passportJWT.ExtractJwt;
const JwtStrategy = passportJWT.Strategy;

export const JWT = new JwtStrategy(
  {
    jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
    secretOrKey: config.jwt.secret,
  },
  function (jwt_payload, done) {
    console.log('payload received', jwt_payload);
    try {
      const user = UserService.getUser(jwt_payload.user_id);

      done(null, user);
    } catch (error) {
      done(error);
    }
  },
);
