import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, Image, TextInput, Pressable, Button } from 'react-native';
import { DPButton } from '../components/DPButton';

const Index = () => {
    const [msg, setMsg] = useState("carregando…");
    const [email, setEmail] = useState();
    const [password, setPassword] = useState();

    const handleSubmit = () => {
        console.log('Nome:', email);
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
                <View className="flex items-center" style={{height: 200}}>
                    <Image
                        source={require('../assets/logo-blue.png')}
                        style={{ width: 200, height: 200 }} />
                </View>
                <Text className="text-center text-2xl font-bold">Bem-vindo a</Text>
                <Text className="text-center text-4xl font-bold mb-10">Direct Prime!</Text>
                <TextInput
                    value={email}
                    onChangeText={setEmail}
                    placeholder="E-mail"
                    className="shadow-md bg-zinc-200 rounded-md h-16 px-8 my-4"
                />

                <TextInput
                    value={password}
                    onChangeText={setPassword}
                    placeholder="Senha"
                    keyboardType="password"
                    secureTextEntry={true}
                    className="shadow-md bg-zinc-200 rounded-md h-16 px-8 my-4"
                />

                <DPButton title="Login" className={"bg-slate-700 p-4 mt-4 rounded-xl shadow-sm"}/>
                <Text className="text-slate-600 font-bold text-2xl text-center m-4">Ou</Text>
                <DPButton title="Registrar" textClassName={"text-slate-700 text-center font-bold"} className={"border-slate-700 border-2 p-4 rounded-xl"}/>
            </View>
        </View>
    );
}

export default Index;