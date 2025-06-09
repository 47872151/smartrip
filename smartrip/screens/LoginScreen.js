import { StatusBar } from 'expo-status-bar';
import React, { useEffect, useState } from 'react';
import { StyleSheet, Text, View, TextInput, Pressable } from 'react-native';
import { FontAwesome } from '@expo/vector-icons';
import * as SplashScreen from 'expo-splash-screen';
import { ImageBackground } from 'react-native';
import * as Font from 'expo-font';
import { useNavigation } from '@react-navigation/native';
export default function Login() {
  const navigation = useNavigation();
  const [user, setUser] = React.useState("");
  const [contraseña, setContraseña] = React.useState("");
  const [fontsLoaded, setFontsLoaded] = useState(false);

  useEffect(() => {
    SplashScreen.preventAutoHideAsync();
    async function loadFonts() {
      await Font.loadAsync({
        'Unageo-Medium': require('../assets/fonts/Unageo-Medium.ttf'),
        'Coolvetica-Rg': require('../assets/fonts/Coolvetica-Rg-It.otf'),
      });
      setFontsLoaded(true);
      await SplashScreen.hideAsync();
    }
    loadFonts();
  }, []);
  if (!fontsLoaded) {
    return null;
  }
  const validarContraseña = (c) =>{
    return true;
  }
  const validarUser = (c) =>{
    return true;
  }
  const handleSubmit = () => {
    const userValido = validarUser(user);
    const contraseñaValida = validarContraseña(contraseña);
    if (userValido && contraseñaValida) {
      navigation.navigate('HomeStack');
    }
      else {
      alert("Verificá los datos. Algo está mal.");
    }
  };
  return (
        <View style={styles.container}>
        <View style={styles.logoContainer}>
          <ImageBackground source={require('../assets/imgs/LOGO.png')} resizeMode='contain' style={styles.image} />
        </View>  
        <StatusBar style="auto" /> 
        <View style={styles.form}>   
        <Text style={ styles.texto }>¿Cuál es tú número de teléfono o email?</Text>
        <TextInput style={styles.input} placeholder="Introducí tú número de teléfono o email" placeholderTextColor="rgba(3, 4, 94, 0.6)" value={user} onChangeText={setUser} />
        <View style = {styles.textContraseña}>
        <Text style={ styles.texto }>Contraseña</Text>
        <Text style={styles.olvPass}>Olvidé mi contraseña</Text>
        </View>
        <TextInput secureTextEntry={true} placeholder="Contraseña" placeholderTextColor="rgba(3, 4, 94, 0.6)" value={contraseña} onChangeText={setContraseña} style={styles.input} />
        <View style={{ width: '100%' }}>
        </View>
        <Pressable style={styles.button1} onPress={handleSubmit}>
          <Text style={styles.buttonText1}>Iniciar sesión</Text>    
          <FontAwesome name="sign-in" size={20} color="white" marginLeft="10" />
        </Pressable>
        <View style={styles.textContraseña}>
        <View style={styles.botones}>
        </View>
        <Text>O continuar con</Text>
        <View style={styles.botones}>
        </View>
        </View>
        <Pressable style={styles.button2}>
          <FontAwesome name="google" size={20} color="#03045E" marginRight="5" />
          <Text style={styles.buttonText2}>Continuar con Google</Text>
        </Pressable>
        <Pressable style={styles.button1}>
          <Text style={styles.buttonText1}>Registrarse</Text>
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
    margin: 20,
    marginLeft: 3,
    borderColor: '#03045E',
  },
  textContraseña: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginTop: 10,
  },
  texto: {
    fontSize: 16,
    color: "#03045E",
    fontFamily: 'Inter'
  },
  olvPass: {
    textAlign: "right",
    fontSize: 16,
    marginBottom: 5,
    color: "#03045E",
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
    color: '#03045E',
    fontFamily: 'Inter'
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
    backgroundColor: '#CAF0F8',
    borderRadius: 10,
    width: '100%',
    justifyContent: 'center',
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
    color: '#03045E',
    fontFamily: 'Inter'
  },
});
