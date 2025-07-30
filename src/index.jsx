import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet } from 'react-native';

const App = () => {
  const [msg, setMsg] = useState("carregando…");

  useEffect(() => {
    fetch("http://192.168.100.238:8000/api/hello")  
      .then(res => res.json())
      .then(data => setMsg(data.message))
      .catch(err => setMsg("Erro: " + err.message));
  }, []);

  return (
    <View style={styles.container}>
      <Text style={styles.text}>{msg}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#fff',
  },
  text: { fontSize: 18 }
});

export default App;