import { StyleSheet } from "react-native";

const textInputStyles = StyleSheet.create({
  input: {
    width: '80%',
    padding: 15,
    marginBottom: 10,
    borderWidth: 1,
    borderColor: '#ccc',
    borderRadius: 10,
    textAlign: 'center',
    backgroundColor: '#464646', // Grey fill color for the input fields
    color: '#939393', // Text color inside the inputs
    textDecorationColor: '#939393',
    fontSize: 16, // Adjust the size as needed
  },
})

export { textInputStyles }