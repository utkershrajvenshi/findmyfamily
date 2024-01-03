import { StyleSheet } from "react-native";

const roomCreatedStyles = StyleSheet.create({
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
    width: 400,
    textAlign: 'center'
  },
  joiningId: {
    fontSize: 40,
    fontWeight: '900',
    color: '#441940',
    textAlign: 'center'
  },
  copyText: {
    fontSize: 18,
    fontWeight: 'normal',
    color: '#939393',
    textAlign: 'center',
    marginBottom: '10%'
  },
  buttonWrapper: {
    marginBottom: 90
  }
})

export { roomCreatedStyles }
