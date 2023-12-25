const HERO_TITLE_COLOR = '#AD6FA7'

enum availableActivityTypes {
  getStarted,
  continue
}

const getButtonColorways = (activityType: keyof typeof availableActivityTypes) => {
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