import "@typespec/http";
import "../models/error.tsp";
import "../models/rental.tsp";

using Http;

namespace RentService;

@route("/api/v1/auth")
@tag("Auth")
interface AuthRoutes {
  @post
  @route("/register")
  register(@body body: RegisterBody): AuthOk | ConflictError | ValidationError | ServerError;

  @post
  @route("/login")
  login(@body body: LoginBody): AuthOk | UnauthorizedError | ValidationError | ServerError;
}
