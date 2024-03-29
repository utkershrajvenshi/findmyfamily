import { StyleSheet } from 'react-native';
import { HERO_TITLE_COLOR, getButtonColorways } from './colors';

const WelcomeScreenStyles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#FFFFFF',
    alignItems: 'center',
    justifyContent: 'center',
  },
  logo: {
    width: 150, // Set the width as needed
    height: 150, // Set the height as needed
    marginBottom: 24, // Space between logo and text
  },
  title: {
    fontSize: 36,
    fontWeight: '900',
    color: HERO_TITLE_COLOR, // Adjust the color to match your design
    marginBottom: 48, // Space between title and button
  },
});

export { WelcomeScreenStyles }