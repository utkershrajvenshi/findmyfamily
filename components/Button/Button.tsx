import React from "react";
import { Pressable, Text } from "react-native";
import { ButtonStyles } from "./Button.styles";
import { ActivityTypes, stringMappings } from "../../constants";
import { Href } from "expo-router/src/link/href";
import { Link } from "expo-router";

interface IButton {
  variant: ActivityTypes
  href?: Href
  onClick?: () => void
}
const Button: React.FC<IButton> = ({ variant, onClick, href }: IButton) => {
  const styles = ButtonStyles(variant)
  if (href) {
    return (
      <Link asChild href={href}>
        <Pressable style={styles.button} onPress={onClick}>
          <Text style={styles.buttonText}>{stringMappings[variant]}</Text>
        </Pressable>
      </Link>
    )
  }
  return (
    <Pressable style={styles.button} onPress={onClick}>
      <Text style={styles.buttonText}>{stringMappings[variant]}</Text>
    </Pressable>
  )
}

export { Button }

// TODO: prefer block-arrow notation
// TODO: Prefer to tell users that some variables are unused