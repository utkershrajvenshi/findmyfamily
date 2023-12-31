import React from "react";
import { View, Image, Text } from "react-native";
import { stringMappings } from "../constants";
import { Button } from "../components/Button";
import { createOrJoinGroupStyles as styles } from "../styles/create-or-join-group.styles";

export default function CreateOrJoinGroup() {
  const sampleOnPressCreate = () => console.log('Navigate to create group screen')
  const sampleOnPressJoin = () => console.log('Navigate to join group screen')

  return (
    <View style={styles.container}>
      <Image
        source={require('../assets/app-logo.png')} // Replace with your logo image file
        style={styles.logoContainer} />
      <Text style={styles.title}>
        {stringMappings.createOrJoinAFamilyGroup}
      </Text>
      <View style={styles.buttonGroup}>
        <Button onClick={sampleOnPressCreate} variant="createAGroup" href="/create-group" />
        <Button onClick={sampleOnPressJoin} variant="joinAGroup" href="/join-group" />
      </View>
    </View>
  );
}