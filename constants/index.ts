enum availableActivityTypes {
  getStarted,
  continue,
  login,
  email,
  password,
  loginToContinue,
  createOrJoinAFamilyGroup,
  createAGroup,
  joinAGroup,
  yourFamilyGroupIdIsReady,
  copy,
  enterYourGroupName,
  proceed
}

type ActivityTypes = keyof typeof availableActivityTypes

const stringMappings: Record<ActivityTypes, string> = {
  continue: 'Continue',
  getStarted: 'Get Started',
  login: 'Login',
  email: 'Email',
  password: 'Password',
  loginToContinue: 'Login to continue:',
  createOrJoinAFamilyGroup: 'Create or Join a family group',
  createAGroup: 'Create a group',
  joinAGroup: 'Join a group',
  yourFamilyGroupIdIsReady: 'Your family group ID is ready',
  copy: 'Copy',
  enterYourGroupName: 'Enter your group name',
  proceed: 'Proceed'
}

export { stringMappings }
export type { ActivityTypes }

// TODO: Prefer quote-less string in object keys if no spaces are there
// TODO: Prefer to end with a newline
// TODO: Prefer to not have a trailing comma in an object for the last key