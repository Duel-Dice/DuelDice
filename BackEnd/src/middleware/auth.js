import passport from 'passport';

export function Auth(req, res, next) {
  passport.authenticate('jwt', { session: false });
}
