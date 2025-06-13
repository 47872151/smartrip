import { StatusBar } from 'expo-status-bar';
import React, { useEffect, useState } from 'react';
import { StyleSheet, Text, View, TextInput, Pressable} from 'react-native';
import { FontAwesome } from '@expo/vector-icons';
import * as SplashScreen from 'expo-splash-screen';
import { ImageBackground } from 'react-native';
import axios from 'axios';
import { useNavigation } from '@react-navigation/native';
import AsyncStorage from '@react-native-async-storage/async-storage';
import Registrarse1Screen from './Registrarse1Screen';
import Registrarse1Screen from '../tabs/Registrarse1Tab';
export default function Login() {
  const navigation = useNavigation();
  const [user, setUser] = React.useState("");
  const [contraseña, setContraseña] = React.useState("");
  SplashScreen.preventAutoHideAsync();
  const validarContraseña = (c) =>{
    return true;
  }
  const BD = "https://1f90-190-55-100-17.ngrok-free.app"
  useEffect(() => {
    axios.get('https://bf3d-200-73-176-50.ngrok-free.app/')
      .then(() => console.log('Servidor accesible'))
      .catch(e => console.log('Error conectando al servidor:', e.message));
  }, []);
  
  const validarUser = (c) =>{
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/i;
    const telefonoRegex = /^\+54\s?9\s?(\d{2})\s?(\d{4})[-\s]?(\d{4})$/;
    if (c.includes('@')) {
      return emailRegex.test(c);
    } else if (c.includes('+54')){
      const telSinEspacios = c.replace(/\s+/g, '');
      return telefonoRegex.test(telSinEspacios);
    }  }
    const handleSubmit = async () => {
      const userValido = validarUser(user);
      const contraseñaValida = validarContraseña(contraseña);
    
      if (!userValido || !contraseñaValida) {
        alert("Verificá los datos. Algo está mal.");
        return;
      }
    
      try {
        let endpoint = '';
        let data = {};
    
        if (user.includes('@')) {
          endpoint = 'loginMail';
          data = { email: user, password: contraseña };
        } else if (user.includes('+54')) {
          endpoint = 'loginTel';
          data = { tel: user, password: contraseña };
        } else {
          alert("Formato no reconocido.");
          return;
        }
    
        const res = await axios.post(`${BD}${endpoint}`, data);
        const token = res.data.token;
        await AsyncStorage.setItem('token', token);
        alert('Login exitoso');
        navigation.navigate('HomeStack');
      } catch (error) {
        console.log(error);
        alert(error.response?.data?.error || 'Error al iniciar sesión');
      }
    };
    
  SplashScreen.hideAsync();
  return (
    
        <View style={styles.container}>
        <View style={styles.logoContainer}>
          <ImageBackground source={require('../assets/imgs/LOGO.png')} resizeMode='contain' style={styles.image} />
        </View>  
        <StatusBar style="auto" /> 
        <View style={styles.form}>   
        <Text style={ styles.texto }>¿Cuál es tú número de teléfono o email?</Text>
        <TextInput style={styles.input} placeholder="Introducí tú número de teléfono o email" value={user} onChangeText={setUser} />
        <View style = {styles.textContraseña}>
        <Text style={ styles.texto }>Contraseña</Text>
        <Text style={styles.olvPass}>Olvidé mi contraseña</Text>
        </View>
        <TextInput secureTextEntry={true} placeholder="Contraseña" value={contraseña} onChangeText={setContraseña} style={styles.input} />
        <View style={{ width: '100%' }}>
        </View>
        <Pressable style={styles.button1} onPress={handleSubmit}>
          <Text style={styles.buttonText1}>Iniciar sesión</Text>    
          <FontAwesome name="sign-in" size={20} color="white" marginLeft="10" />
        </Pressable>
        <View style={[styles.textContraseña, { padding: 15 }]}>
        <View style={styles.botones}>
        </View>
        <Text style={styles.continuar}>O continuar con</Text>
        <View style={styles.botones}>
        </View>
        </View>
        <Pressable style={styles.button2}>
          <FontAwesome name="google" size={20} color="#03045E" marginRight="5" />
          <Text style={styles.buttonText2}>Continuar con Google</Text>
        </Pressable>
        <View style={[styles.textContraseña, { padding: 5 }, { paddingTop: 15 }]}>
        <Text style={styles.continuar}>¿No tienes una cuenta?</Text>
        </View>
        <Pressable style={styles.button3} onPress={() => navigation.navigate('RegistrarseStack')}>
          <Text style={styles.buttonText3}>Registrarse</Text>
        </Pressable>
        </View>
      </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
    paddingHorizontal: 20,
  },
  form:{
    width: "100%",
    marginTop: 100,
    marginBottom: 100,
    borderColor: '#90E0EF',
    borderWidth: 0,
    padding: 25,
    borderRadius: "5%",
    backgroundColor: "rgba(202, 240, 248, 0.4)"
  },
  image: {
    width: 200,
    height: 100,
    marginTop: 20,
  },  
  logoContainer: {
    marginTop: "15%",
    marginBottom: "-25%",
    },  
  botones:{
    width: '30%',
    borderTopWidth: 1,
    borderColor: '#C3C7CA',
  },
  continuar:{
    color: '#6B7280',
  },
  textContraseña: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginTop: 10,
  },
  texto: {
    fontSize: 16,
    color: "#111827",
    fontFamily: 'Inter'
  },
  olvPass: {
    textAlign: "right",
    fontSize: 16,
    marginBottom: 5,
    color: "#008798",
    fontFamily: 'Inter',
  },
  input: {
    width: '100%',
    borderWidth: 2,
    borderColor: '#90E0EF',
    borderRadius: 10,
    padding: 16,
    marginVertical: 8,
    fontSize: 18,
    backgroundColor: '#CAF0F8',
    fontFamily: 'Inter',
    color: '#CDCDCD'
  },  
  button1: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 18,
    marginVertical: 5,
    marginTop: 15,
    backgroundColor: '#00B4D8',
    borderRadius: 10,
    width: '100%',
    justifyContent: 'center',
    
  },
  button2: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 18,
    marginVertical: 5,
    borderWidth: 1,
    borderColor: "#90E0EF",
    borderRadius: 10,
    width: '100%',
    justifyContent: 'center',
  },
  button3: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 18,
    marginVertical: 5,
    borderWidth: 1,
    borderColor: "#90E0EF",
    borderRadius: 10,
    width: '100%',
    justifyContent: 'center',
    backgroundColor: "#DFFBFF"
  },
  buttonText1: {
    marginLeft: 8,
    color: 'white',
    fontSize: 18,
    fontFamily: 'Inter'
  },
  buttonText2: {
    marginLeft: 8,
    fontSize: 18,
    color: '#1F2937',
    fontFamily: 'Inter'
  },
  buttonText3: {
    marginLeft: 8,
    fontSize: 18,
    color: '#00BCD4',
    fontFamily: 'Inter'
  },
});
