import { ActivityTypes } from "../constants"

const HERO_TITLE_COLOR = '#AD6FA7'

const getButtonColorways = (activityType: ActivityTypes) => {
  switch (activityType) {
    case 'getStarted':
    case 'continue': {
      return {
        background: '#FA5151',
        textColor: '#FFFFFF'
      }
    }
  }
}

export {
  HERO_TITLE_COLOR,
  getButtonColorways
}

// TODO: Prefer to ask for a default value in a switch-case statement