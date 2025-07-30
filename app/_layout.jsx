import { Stack } from 'expo-router';
import { useEffect } from 'react';
import * as SplashScreen from 'expo-splash-screen';
import "../global.css";

SplashScreen.hideAsync();

export default function RootLayout() {
  return (
    <Stack>
        <Stack.Screen name="index" options={{ headerShown: false }} />
    </Stack>
  );
}
