enum HttpCode {
  ok(200),
  badRequest(400),
  unauthorized(401),
  notFound(404),
  conflict(409),
  internalServerError(500);

  const HttpCode(this.value);
  final int value;
}
