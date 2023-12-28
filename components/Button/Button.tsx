import React from "react";
import { Pressable, Text } from "react-native";
import { ButtonStyles } from "./Button.styles";
import { ActivityTypes, stringMappings } from "../../constants";

interface IButton {
  variant: ActivityTypes
  onClick?: () => void
}
const Button: React.FC<IButton> = ({ variant, onClick }: IButton) => {
  const styles = ButtonStyles(variant)
  return (
    <Pressable style={styles.button} onPress={onClick}>
      <Text style={styles.buttonText}>{stringMappings[variant]}</Text>
    </Pressable>
  )
}

export { Button }

// TODO: prefer block-arrow notation
// TODO: Prefer to tell users that some variables are unused