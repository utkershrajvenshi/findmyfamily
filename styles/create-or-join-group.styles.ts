import { StyleSheet } from "react-native";

const createOrJoinGroupStyles = StyleSheet.create({
  container: {
    width: '100%',
    height: '100%',
    display: 'flex',
    justifyContent: 'space-evenly',
    alignItems: 'center',
  },
  logoContainer: {
    width: 54, // Set the width as needed
    height: 54, // Set the height as needed
    marginBottom: 20
  },
  title: {
    fontSize: 32,
    fontWeight: 'bold',
    marginBottom: 20,
    color: '#333',
    width: 250,
    textAlign: 'center'
  },
  buttonGroup: {
    display: 'flex',
    flexDirection: 'column',
    height: '30%',
    width: '50%',
    justifyContent: 'space-evenly',
    marginBottom: '50%'
  }
})
/* 
const colorList = [
  {offset: '0%', color: '#FFFFFF', opacity: '1'},
  {offset: '100%', color: 'rgba(0, 0, 186, 0.53)', opacity: '0.53'}
]

const gradientColors = ['#FFFFFF', 'black'] */

export { createOrJoinGroupStyles }
