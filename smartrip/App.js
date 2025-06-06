import { StatusBar } from 'expo-status-bar';
import React, { useEffect, useState } from 'react';
import { StyleSheet, Text, View, TextInput, Pressable } from 'react-native';
import { FontAwesome } from '@expo/vector-icons';
import * as SplashScreen from 'expo-splash-screen';
import { ImageBackground } from 'react-native';
import * as Font from 'expo-font';
export default function App() {
  
  const [user, setUser] = React.useState("");
  const [contraseña, setContraseña] = React.useState("");
  const [fontsLoaded, setFontsLoaded] = useState(false);

  useEffect(() => {
    SplashScreen.preventAutoHideAsync();
    async function loadFonts() {
      await Font.loadAsync({
        'Unageo-Medium': require('./assets/fonts/Unageo-Medium.ttf'),
        'Coolvetica-Rg': require('./assets/fonts/Coolvetica-Rg-It.otf'),
      });
      setFontsLoaded(true);
      await SplashScreen.hideAsync();
    }
    loadFonts();
  }, []);
  if (!fontsLoaded) {
    return null;
  }
  const handleSubmit = (e) => {
    const userValido = validarUser(user);
    const contraseñaValida = validarContraseña(contraseña);
    if (userValido && contraseñaValida) {
      alert("Te registraste correctamente. ¡Bienvenido a bordo!");
      //enviar a la proxima pagina
    } else {
      alert("Verificá los datos. Algo está mal.");
    }
  };
  return (
        <View style={styles.container}>  
        <StatusBar style="auto" /> 
        <View style={styles.form}>   
        <Text style={ styles.texto }>¿Cuál es tú número de teléfono o email?</Text>
        <TextInput style={styles.input} placeholder="Introducí tú número de teléfono o email" placeholderTextColor="rgba(3, 4, 94, 0.6)" value={user} onChangeText={setUser} />
        <TextInput secureTextEntry={true} placeholder="Contraseña" placeholderTextColor="rgba(3, 4, 94, 0.6)" value={contraseña} onChangeText={setContraseña} style={styles.input} />
        <View style={{ width: '100%' }}>
        <Text style={styles.olvPass}>Olvidé mi contraseña</Text>
        </View>
        <Pressable style={styles.button1} onPress={handleSubmit}>
          <Text style={styles.buttonText1}>Iniciar sesión</Text>    
          <FontAwesome name="sign-in" size={20} color="white" marginLeft="10" />
        </Pressable>
        <View style={styles.botones}>
        </View>
        <Pressable style={styles.button2}>
          <FontAwesome name="google" size={20} color="#03045E" marginRight="5" />
          <Text style={styles.buttonText2}>Continuar con Google</Text>
        </Pressable>
        <Pressable style={styles.button1}>
          <Text style={styles.buttonText1}>Registrarse</Text>
        </Pressable>
        </View>
        <View style={styles.logoContainer}>
          <ImageBackground source={require('./assets/imgs/LOGO.png')} resizeMode='contain' style={styles.image} />
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
  },
  image: {
    width: 200,
    height: 100,
    marginTop: 20,
  },  
  logoContainer: {
    marginBottom: -30,
    },  
  olvPass: {
    textAlign: "right",
    fontSize: 16,
    marginBottom: 5,
    color: "#03045E",
    textDecorationLine: 'underline',
    fontFamily: 'Unageo-Medium'
  },
  botones:{
    width: '100%',
    borderTopWidth: 1,
    margin: 20,
    marginLeft: 3,
    borderColor: '#03045E',
  },
  input: {
    width: '100%',
    borderWidth: 5,
    borderColor: '#CAF0F8',
    borderRadius: 20,
    padding: 12,
    marginVertical: 8,
    fontSize: 18,
    backgroundColor: '#CAF0F8',
    color: '#03045E',
    fontFamily: 'Unageo-Medium'
  },  
  texto: {
    fontSize: 26,
    color: "#03045E",
    fontFamily: 'Unageo-Medium'
  },
  button1: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 18,
    marginVertical: 5,
    marginTop: 15,
    backgroundColor: '#00B4D8',
    borderRadius: 15,
    width: '100%',
    justifyContent: 'center',
    
  },
  button2: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 18,
    marginVertical: 5,
    backgroundColor: '#CAF0F8',
    borderRadius: 15,
    width: '100%',
    justifyContent: 'center',
  },
  buttonText1: {
    marginLeft: 8,
    fontWeight: 'bold',
    color: 'white',
    fontSize: 18,
    fontFamily: 'Unageo-Medium'
  },
  buttonText2: {
    marginLeft: 8,
    fontWeight: 'bold',
    fontSize: 18,
    color: '#03045E',
    fontFamily: 'Unageo-Medium'
  },
});
