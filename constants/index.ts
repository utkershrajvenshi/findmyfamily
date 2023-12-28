enum availableActivityTypes {
  getStarted,
  continue,
  login,
  email,
  password,
  loginToContinue
}

type ActivityTypes = keyof typeof availableActivityTypes

const stringMappings: Record<ActivityTypes, string> = {
  continue: 'Continue',
  getStarted: 'Get Started',
  'login': 'Login',
  email: 'Email',
  password: 'Password',
  loginToContinue: 'Login to continue:'
}

export { stringMappings }
export type { ActivityTypes }

// TODO: Prefer quote-less string if no spaces are there
// TODO: Prefer to end with a newline
// TODO: Prefer to not have a trailing comma in an object for the last key