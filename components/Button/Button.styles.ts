import { StyleSheet } from "react-native"
import { getButtonColorways } from "../../styles/colors"
import { ActivityTypes } from "../../constants"

const ButtonStyles = (variant: ActivityTypes) => {
  const buttonColorways = getButtonColorways(variant)
  return StyleSheet.create({
    button: {
      backgroundColor: buttonColorways?.background, // Button background color
      padding: 16,
      alignItems: 'center',
      borderRadius: 25, // Adjust for rounded corners
    },
    buttonText: {
      color: buttonColorways?.textColor,
      fontSize: 20,
      fontWeight: '600'
    },
  })
}

export { ButtonStyles }
