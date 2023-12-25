import { Account, ID } from "appwrite";
import client from "./index";

const account = new Account(client)

type ILoginSignUp = {email: string, password: string}

class UserAuthentication {
  public static signUp({ email, password }: ILoginSignUp, callbackFn?: Function, errorHandler?: Function) {
    const promise = account.create(ID.unique(), email, password);
    
    promise.then(
      (response) => {
        console.log('Sign up successful: ', response)
        if (callbackFn) callbackFn()
      },
      (error) => errorHandler?.(error)
    );
  }

  public static login({ email, password }: ILoginSignUp, callbackFn?: Function, errorHandler?: Function) {
    const promise = account.createEmailSession(email, password)
    promise.then(
      (response) => {
        console.log('Success', response)
        if (callbackFn) callbackFn()
      },
      (error) => errorHandler?.(error)
    );
  }

  public static logout() {
    const promise = account.deleteSession('current')
    promise.then(
      (response) => console.log('Successfully logged out. ', response),
      (error) => alert(error.message)
    )
  }
}

export {
  UserAuthentication
}