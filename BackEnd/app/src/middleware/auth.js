import passport from 'passport';

export const Auth = passport.authenticate('firebase-jwt', { session: false });
