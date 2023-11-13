import { ConfigContext, ExpoConfig } from 'expo/config'

export default ({ config }: ConfigContext): ExpoConfig => ({
  ...config,
  name: 'FindMyFamily',
  slug: 'findmyfamily',
  // All values in extra will be passed to your app.
  extra: {
    appwriteAppId: process.env.APPWRITE_APP_ID
  },
})
