import { Account, ID } from "appwrite";
import client from "./index";

const account = new Account(client)

class UserAuthentication {
  public static signUp(email: string, password: string) {
    const promise = account.create(ID.unique(), email, password);
    
    promise.then(
      (response) => console.log('Sign up successful: ', response),
      (error) => console.log('Error signing up', error)
    );
  }

  public static login(email: string, password: string) {
    const promise = account.createEmailSession(email, password);
    promise.then(
      (response) => console.log('Success', response),
      (error) => console.log('Error logging in', error)
    );
  }

  public static logout() {
    const promise = account.deleteSession('current')
    promise.then(
      (response) => console.log('Successfully logged out. ', response),
      (error) => console.log('Error while logging out ', error)
    )
  }
}

export {
  UserAuthentication
}