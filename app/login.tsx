import React, { useState } from 'react';
import { RadialGradient } from 'react-native-gradients';
import { styles, colorList } from '../styles/login.styles';
import { View, TextInput, Text, Pressable, Image } from 'react-native';
import { UserAuthentication } from '../config/authentication';
import { useRouter } from 'expo-router/src/hooks';
import { stringMappings } from '../constants';

export default function Login() {
  const [email, setEmail] = useState<string>()
  const [password, setPassword] = useState<string>()
  const router = useRouter()

  const onClickContinue = () => {
    if (email && password) {
      UserAuthentication.login(
        {email, password},
        () => {
          router.replace('/create-or-join-group')
        },
        (error: unknown) => {
          alert((error as Error).message)  
        }
      )
    }
  }

  return (
    <>
      <View>
        <RadialGradient x="15%" y="0%" rx="100%" ry="100%" colorList={colorList} />
      </View>
      <View style={styles.container}>
        <Image
          source={require('../assets/app-logo.png')} // Replace with your logo image file
          style={styles.logoContainer} />
        <Text style={styles.title}>{stringMappings.loginToContinue}</Text>
        <TextInput
          style={styles.input}
          placeholder={stringMappings.email}
          placeholderTextColor="#939393"
          keyboardType="email-address"
          value={email}
          onChangeText={setEmail}
          autoCapitalize="none" />
        <TextInput
          style={styles.input}
          placeholder={stringMappings.password}
          placeholderTextColor="#939393"
          value={password}
          onChangeText={setPassword}
          secureTextEntry
          autoCapitalize="none" />
        <Pressable style={styles.button} onPress={onClickContinue}>
          <Text style={styles.buttonText}>{stringMappings.continue}</Text>
        </Pressable>
      </View>
    </>
  );
}
