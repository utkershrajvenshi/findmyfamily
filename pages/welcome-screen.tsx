import React from 'react';
import { Text, View, Image } from 'react-native';
import { WelcomeScreenStyles } from '../styles/welcome-screen.styles';
import { Button } from '../components/Button';
import { Link } from 'expo-router';

const sampleOnPress = () => console.log('Navigate to next screen')

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
      <Link asChild href="/login">
        <Button onClick={sampleOnPress} variant="getStarted" />
      </Link>
    </View>
  );
}

export { WelcomeScreen }