import React, { useState, useRef } from "react";
import { View, Image, Text, ImageBackground, Pressable } from "react-native";
import { stringMappings } from "../constants";
import { Button } from "../components/Button";
import { roomCreatedStyles } from "../styles/room-created.styles";
import { randomStringGenerator } from "../utils";
import { CustomTextInput } from "../components/CustomTextInput";
import * as Clipboard from 'expo-clipboard'

export default function CreateOrJoinGroup() {
  const joiningId = useRef(randomStringGenerator())
  const [groupName, setGroupName] = useState<string>()

  const sampleOnPressProceed = () => console.log('Navigate to home screen groupName: ', groupName)
  const sampleOnPressCopy = () => {
    Clipboard.setStringAsync(joiningId.current)
      .then(() => console.log('Text copied to clipboard!'))
      .catch((error) => console.error('Error copying text:', error))
  }

  return (
    <ImageBackground source={require('../assets/gradient2.png')} style={roomCreatedStyles.container} imageStyle={{
      resizeMode: 'stretch',
    }}>
      <Image
        source={require('../assets/app-logo.png')} // Replace with your logo image file
        style={roomCreatedStyles.logoContainer} />
      <Text style={roomCreatedStyles.title}>
        {stringMappings.yourFamilyGroupIdIsReady}
      </Text>
      <Text style={roomCreatedStyles.joiningId}>
        {joiningId.current}
      </Text>
      <Pressable onPress={sampleOnPressCopy}>
        <Text style={roomCreatedStyles.copyText}>
          {stringMappings.copy}
        </Text>
      </Pressable>
      <CustomTextInput
        placeholder={stringMappings.enterYourGroupName}
        value={groupName}
        onChangeText={setGroupName}
      />
      <View style={roomCreatedStyles.buttonWrapper}>
        <Button onClick={sampleOnPressProceed} variant="proceed" />
      </View>
    </ImageBackground>
  );
}