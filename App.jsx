import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, View } from 'react-native';
import MapView, { Marker } from 'react-native-maps';
import {
  requestForegroundPermissionsAsync,
  getCurrentPositionAsync,
  watchPositionAsync,
  LocationAccuracy
} from "expo-location";
import { useEffect, useState, useRef } from 'react';

async function requestLocationPermissions(setLocationState) {
  const { granted } = await requestForegroundPermissionsAsync();

  if (granted) {
    const currentPosition = await getCurrentPositionAsync();
    setLocationState(currentPosition)
  }
}

export default function App() {
    /** @type {[import('expo-location').LocationObject, import('react').Dispatch<import('expo-location').LocationObject|null>]} */
  const [location, setLocation] = useState(null);
  /** @type {import('react').RefObject<MapView|null>} */
  const mapRef = useRef(null);

  useEffect(() => {
    requestLocationPermissions(setLocation);
  }, []);

  useEffect(() => {
    watchPositionAsync({
      accuracy: LocationAccuracy.Highest,
      timeInterval: 1000,
      distanceInterval: 1
    }, (response) => {
      setLocation(response);
      mapRef.current?.animateCamera({
        pitch: 70,
        center: location.coords
      })
    })
  }, [])

  console.log("Localização atual: ", location);
  return (
    <View style={styles.container}>
      {
        location && 
        <MapView 
          ref={mapRef}
          style={styles.map}
          initialRegion={{
            latitude: location.coords.latitude,
            longitude: location.coords.longitude,
            latitudeDelta: 0.005,
            longitudeDelta: 0.005
          }}
        >
          <Marker coordinate={{
            latitude: location.coords.latitude,
            longitude: location.coords.longitude
          }}/>
          </MapView>
      }
      
      <StatusBar style="auto" />
    </View>
  );
}

export const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "center"
  },
  map: {
    flex: 1,
    width: "100%"
  }
})