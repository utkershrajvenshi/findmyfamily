import React from 'react';
import { RadialGradient } from 'react-native-gradients';
import { StyleSheet, View, TextInput, Text, Pressable, Image } from 'react-native';

const colorList = [
  {offset: '0%', color: '#FFFFFF', opacity: '1'},
  {offset: '36%', color: '#C8F1C1', opacity: '0.96'},
  {offset: '80%', color: '#B7F1E3', opacity: '0.96'},
  {offset: '100%', color: '#8DB1E7', opacity: '0.75'}
]

export default function Login() {
  return (
    <><View>
      <RadialGradient x="15%" y="0%" rx="100%" ry="100%" colorList={colorList} />
      </View>
      <View style={styles.container}>
        <Image
          source={require('../assets/app-logo.png')} // Replace with your logo image file
          style={styles.logoContainer} />
        <Text style={styles.title}>Login to continue:</Text>
        <TextInput
          style={styles.input}
          placeholder="Email"
          placeholderTextColor="#939393"
          keyboardType="email-address"
          autoCapitalize="none" />
        <TextInput
          style={styles.input}
          placeholder="Password"
          placeholderTextColor="#939393"
          secureTextEntry
          autoCapitalize="none" />
        <Pressable style={styles.button}>
          <Text style={styles.buttonText}>Continue</Text>
        </Pressable>
      </View>
      </>
  );
}

const styles = StyleSheet.create({
  container: {
    position: 'absolute',
    width: '100%',
    height: '100%',
    zIndex: 1,
    flex: 1,
    justifyContent: 'space-evenly',
    alignItems: 'center',
    backgroundColor: 'transparent', // use a radial background
    paddingHorizontal: 10,
    paddingVertical: 40
  },
  logoContainer: {
    width: 54, // Set the width as needed
    height: 54, // Set the height as needed
    marginBottom: 20
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
    color: '#333',
  },
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
  button: {
    width: '80%',
    padding: 15,
    borderRadius: 10,
    backgroundColor: '#f76b8a', // Your button color
    alignItems: 'center',
  },
  buttonText: {
    color: '#fff',
    fontWeight: 'bold',
    fontSize: 16,
  },
});
