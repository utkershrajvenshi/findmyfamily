import { Client } from "appwrite";

const client = new Client();

client
  .setEndpoint('https://cloud.appwrite.io/v1')
  .setProject(process.env.PROJECT_ID ?? 'SAMPLE_ID');

export default client