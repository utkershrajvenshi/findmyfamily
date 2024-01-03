import React from "react";
import { TextInput, TextInputProps } from "react-native";
import { textInputStyles } from "./CustomTextInput.styles";

const CustomTextInput: React.FC<TextInputProps> = (props: TextInputProps) => {
  return (
    <TextInput
      style={textInputStyles.input}
      placeholderTextColor="#939393"
      {...props}
    />
  )
}

export { CustomTextInput }