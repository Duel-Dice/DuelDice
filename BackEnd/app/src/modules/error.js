import 'express-async-errors';

export default class ApiError extends Error {
  constructor(statusCode, message) {
    super(message);
    this.statusCode = statusCode;
  }
}

/**
 * 이걸 넣는게 맞는가..?
 */
export async function errorPageNotFound(req, res, next) {
  throw new ApiError(404, `Page Not Found`);
}

/**
 * 의문 :
 *    에러 메세지를 띄워줄 필요가 있을까?
 *    사용자가 이상한 입력을 하지 않을텐데,
 *    서버 log 에서 확인하면 되지, 이걸 메세지로 띄울 필요가 있을까
 */
export async function errorHandler(error, req, res, next) {
  const statusCode = error.statusCode || 500;
  const message = error.message || 'server error';

  res.status(statusCode).send(message);
}
