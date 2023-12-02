import { Client } from "appwrite";

const client = new Client();

client
  .setEndpoint('https://cloud.appwrite.io/v1')
  .setProject('653fc43cde4ebc14c2cf');

export default client