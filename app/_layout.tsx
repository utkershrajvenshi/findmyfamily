import { Stack } from 'expo-router/stack';
import React from 'react';

export const unstable_settings = {
  initialRouteName: '(welcome)',
};


export default function Layout() {
  return (
    <Stack>
      <Stack.Screen name="(welcome)/index" options={{ headerShown: false }} />
    </Stack>
  )
}
