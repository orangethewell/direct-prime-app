import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, Image, TextInput, Button } from 'react-native';
import { styled } from 'nativewind';

const StyledView = styled(View);
const StyledTextInput = styled(TextInput);

const Index = () => {
    const [msg, setMsg] = useState("carregando…");
    const [username, setUsername] = useState();
    const [password, setPassword] = useState();

    const handleSubmit = () => {
        console.log('Nome:', username);
        console.log('Email:', email);
    };

    useEffect(() => {
        fetch("http://192.168.100.238:8000/api/hello")
            .then(res => res.json())
            .then(data => setMsg(data.message))
            .catch(err => setMsg("Erro: " + err.message));
    }, []);

    return (
        <View className="flex-1 items-center justify-center bg-white">
            <View className="w-full p-8">
                <Image
                    source={require('../assets/logo-blue.png')}
                    className="text-center"
                    style={{ width: 200, height: 200 }} />
                <Text>Nome</Text>
                <StyledTextInput
                    value={username}
                    onChangeText={setUsername}
                    placeholder="Seu nome"
                    className="shadow-sm rounded-lg h-12"
                />

                <Text>Email</Text>
                <StyledTextInput
                    value={password}
                    onChangeText={setPassword}
                    placeholder="Seu email"
                    keyboardType="email-address"
                    className="shadow-sm rounded-lg"
                />

                <Button title="Enviar" onPress={handleSubmit} className="bg-blue-800"/>
            </View>
        </View>
    );
}

export default Index;