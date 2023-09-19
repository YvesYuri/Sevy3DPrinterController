enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}

class AuthenticationExceptionHandler {
  static handleException(e) {
    var status;
    switch (e.code) {
      case "ERROR_INVALID_EMAIL":
        status = AuthResultStatus.invalidEmail;
        break;
      case "wrong-password":
        status = AuthResultStatus.wrongPassword;
        break;
      case "user-not-found":
        status = AuthResultStatus.userNotFound;
        break;
      case "ERROR_USER_DISABLED":
        status = AuthResultStatus.userDisabled;
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        status = AuthResultStatus.tooManyRequests;
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        status = AuthResultStatus.operationNotAllowed;
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = "Seu endereço de e-mail parece estar malformado.";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "Sua senha está errada.";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "O usuário com este e-mail não existe.";
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = "O usuário com este e-mail foi desativado.";
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = "Muitas requisições. Tente mais tarde.";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "O login com e-mail e senha não está ativado.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage =
            "O e-mail já foi cadastrado. Faça login ou redefina sua senha.";
        break;
      default:
        errorMessage = "Ocorreu um erro indefinido.";
    }

    return errorMessage;
  }
}
