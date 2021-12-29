import passport from 'passport';

export const Auth = passport.authenticate('jwt', { session: false });
