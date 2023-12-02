import { Client } from "appwrite";
import Constants from 'expo-constants';

const client = new Client();

client
  .setEndpoint('https://cloud.appwrite.io/v1')
  .setProject(Constants.expoConfig?.extra?.appwriteAppId as string);

export default client