import React from 'react';
import { Text, View, Image, TouchableOpacity } from 'react-native';
import { WelcomeScreenStyles } from '../styles/welcome-screen.styles';

// TODO: Add Link to auth screen on clicking Get started

function WelcomeScreen() {
  return (
    <View style={WelcomeScreenStyles.container}>
      {/* Splash Screen Logo */}
      <Image
        source={require('../assets/app-logo.png')} // Replace with your logo image file
        style={WelcomeScreenStyles.logo}
      />
      {/* Splash Screen Text */}
      <Text style={WelcomeScreenStyles.title}>FindMyFamily</Text>
      {/* Get Started Button */}
      <TouchableOpacity style={WelcomeScreenStyles.button} onPress={() => console.log('Navigate to next screen')}>
        <Text style={WelcomeScreenStyles.buttonText}>Get started</Text>
      </TouchableOpacity>
    </View>
  );
}

export { WelcomeScreen }