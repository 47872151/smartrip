import { StatusBar } from 'expo-status-bar';
import React, { useEffect, useState } from 'react';
import { StyleSheet, Text, View, TextInput, Pressable, TouchableOpacity, ScrollView, SafeAreaView, ImageBackground, Platform } from 'react-native';
import * as SplashScreen from 'expo-splash-screen';
import * as Font from 'expo-font';
import { useNavigation } from '@react-navigation/native';
import Stepper from '../screens/componentes/Stepper';
import Icon from 'react-native-vector-icons/MaterialIcons';
import DateTimePicker from '@react-native-community/datetimepicker';
import RNPickerSelect from 'react-native-picker-select';
import { FontAwesome } from '@expo/vector-icons';
import Registrarse2Tab from './Registrarse2Tab';

export default function Registrarse1() {
  const navigation = useNavigation();
  const [persona, setPersona] = useState({
    nombre: '',
    apellido: '',
    fechaNacimiento: null,
    genero: '',
    email: '',
    telefono: '',
    contrasena: ''
  });

  const [errores, setErrores] = useState({
    nombre: false,
    apellido: false,
    fechaNacimiento: false,
    genero: false,
    email: false,
    telefono: false,
    contrasena: false
  });

  const validarTexto = (text) => {
    const regexTexto = /^[A-Za-zÀ-ÿ\s]+$/;
    if (text.trim().length === 0) return "Campo requerido.";
    if (!regexTexto.test(text)) return "Solo letras y espacios.";
    return '';
  };

  const validarFecha = (fecha) => {
    if (!fecha) return "Campo requerido.";
    const fechaActual = new Date();
    const edadMinima = 13;
    const fechaLimite = new Date();
    const edadMaxima = 120;
    const fechaMaxima = new Date();
    fechaMaxima.setFullYear(fechaMaxima.getFullYear() - edadMaxima);
    fechaLimite.setFullYear(fechaLimite.getFullYear() - edadMinima);
    if (isNaN(fecha.getTime())) return "Fecha inválida.";
    if (fecha >= fechaActual) return "La fecha debe ser anterior a hoy.";
    if (fecha > fechaLimite) return "Debes tener al menos 13 años.";
    if (fecha < fechaMaxima) return "Ingrese una fecha válida.";
    return '';
  };

  const validarGenero = (genero) => {
    return genero ? '' : "Selecciona un género.";
  };

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

  if (!fontsLoaded) return null;

  const handleSubmit = () => {
    const nombreError = validarTexto(persona.nombre);
    const apellidoError = validarTexto(persona.apellido);
    const fechaError = validarFecha(persona.fechaNacimiento);
    const generoError = validarGenero(persona.genero);

    setErrores({
      ...errores,
      nombre: nombreError,
      apellido: apellidoError,
      fechaNacimiento: fechaError,
      genero: generoError
    });

    if (!nombreError && !apellidoError && !fechaError && !generoError) {
      navigation.navigate("Registrarse2");
    }
  };

  return (
    <SafeAreaView>
      <ScrollView>
        <View style={styles.container}>
          <StatusBar style="auto" />
          <View style={styles.logoContainer}>
            <ImageBackground source={require('../assets/imgs/LOGO.png')} resizeMode='contain' style={styles.image} />
            <Stepper step={1} steps={3} />
          </View>

          <View style={styles.form}>
            <Text style={styles.h1}>Información Personal</Text>
            <Text style={styles.h2}>Ingresa tus datos para comenzar</Text>

            {/* NOMBRE */}
            <Text style={styles.label}>Nombre</Text>
            <View style={styles.inputContainer}>
              <Icon name="person" size={20} color="#BDD7DD" style={styles.icon} />
              <TextInput
                style={styles.input}
                placeholder="Ingresa tu nombre"
                value={persona.nombre}
                onChangeText={(text) => setPersona({ ...persona, nombre: text })}
              />
            </View>
            {errores.nombre ? <Text style={styles.errorText}>{errores.nombre}</Text> : null}

            {/* APELLIDO */}
            <Text style={styles.label}>Apellido</Text>
            <View style={styles.inputContainer}>
              <Icon name="person" size={20} color="#BDD7DD" style={styles.icon} />
              <TextInput
                style={styles.input}
                placeholder="Ingresa tu apellido"
                value={persona.apellido}
                onChangeText={(text) => setPersona({ ...persona, apellido: text })}
              />
            </View>
            {errores.apellido ? <Text style={styles.errorText}>{errores.apellido}</Text> : null}

            {/* FECHA DE NACIMIENTO */}
            <Text style={styles.label}>Fecha de nacimiento</Text>
            <View style={styles.inputContainer}>
              <Icon name="calendar-today" size={20} color="#BDD7DD" style={styles.icon} />
              <DateTimePicker
                value={persona.fechaNacimiento || new Date()}
                mode="date"
                display="default"
                onChange={(event, selectedDate) => {
                  if (selectedDate) {
                    setPersona({ ...persona, fechaNacimiento: selectedDate });
                  }
                }}
                style={{ flex: 1, backgroundColor: '#CAF0F8', borderRadius: 10 }}
                maximumDate={new Date()}
              />
            </View>
            {errores.fechaNacimiento ? <Text style={styles.errorText}>{errores.fechaNacimiento}</Text> : null}

            {/* GÉNERO */}
            <Text style={styles.label}>Género</Text>
            <View style={styles.inputContainer}>
              <RNPickerSelect
                onValueChange={(value) => setPersona({ ...persona, genero: value })}
                value={persona.genero}
                items={[
                  { label: 'Hombre', value: 'hombre' },
                  { label: 'Mujer', value: 'mujer' },
                  { label: 'Prefiero no decirlo', value: 'no_decir' },
                ]}
                placeholder={{
                  label: 'Seleccionar',
                  value: '',
                  color: '#BDD7DD',
                }}
                style={{
                  inputIOS: styles.pickerInput,
                  inputAndroid: styles.pickerInput,
                  iconContainer: styles.pickerIconContainer,
                }}
                useNativeAndroidPickerStyle={false}
                Icon={() => {
                  return <Icon name="arrow-drop-down" size={24} color="#000" />;
                }}
              />
            </View>
            {errores.genero ? <Text style={styles.errorText}>{errores.genero}</Text> : null}

            {/* BOTÓN CONTINUAR */}
            <Pressable style={styles.button1} onPress={handleSubmit}>
              <Text style={styles.buttonText1}>Continuar</Text>
              <FontAwesome name="arrow-right" size={20} color="white" style={{ marginLeft: 10 }} />
            </Pressable>

            {/* REDES SOCIALES */}
            <View style={styles.separatorContainer}>
              <View style={styles.line} />
              <Text style={styles.separatorText}>O regístrate con</Text>
              <View style={styles.line} />
            </View>

            <View style={styles.socialButtons}>
              <TouchableOpacity style={styles.button2}>
                <FontAwesome name="google" size={20} color="#458F4" />
                <Text style={styles.buttonText2}>Google</Text>
              </TouchableOpacity>
              <TouchableOpacity style={styles.button2}>
                <FontAwesome name="facebook" size={20} color="#3b5998" />
                <Text style={styles.buttonText2}>Facebook</Text>
              </TouchableOpacity>
            </View>

            <Text style={{ marginTop: 20, textAlign: 'center' }}>
              ¿Ya tienes una cuenta? <Text style={{ color: '#00B4D8' }}>Iniciar Sesión</Text>
            </Text>
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    paddingHorizontal: 20,
    paddingVertical: 40,
  },
  logoContainer: {
    marginTop: 10,
    alignItems: 'center',
  },
  image: {
    width: 200,
    height: 100,
  },
  form: {
    width: '100%',
    marginTop: 20,
    marginBottom: 20,
    padding: 20,
    borderRadius: 15,
    backgroundColor: 'rgba(202, 240, 248, 0.3)',
  },
  h1: {
    fontSize: 22,
    fontWeight: 'bold',
    marginBottom: 5,
    color: '#000',
  },
  h2: {
    fontSize: 14,
    marginBottom: 20,
    color: '#6B7280',
  },
  label: {
    fontWeight: 'bold',
    marginTop: 10,
    color: '#000',
  },
  inputContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    borderWidth: 2,
    borderColor: '#90E0EF',
    borderRadius: 10,
    paddingHorizontal: 10,
    marginVertical: 8,
    backgroundColor: '#CAF0F8',
    height: 50,
  },
  input: {
    flex: 1,
    fontSize: 16,
    color: '#000',
  },
  pickerInput: {
    flex: 1,
    fontSize: 16,
    color: '#000',
    paddingVertical: 12,
    paddingHorizontal: 8,
  },
  pickerIconContainer: {
    position: 'absolute',
    top: Platform.OS === 'ios' ? 12 : 18,
    right: 10,
  },
  icon: {
    marginRight: 10,
  },
  errorText: {
    color: 'red',
    fontSize: 12,
    marginLeft: 5,
    marginBottom: 5,
  },
  separatorContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginVertical: 20,
  },
  line: {
    flex: 1,
    height: 1.5,
    backgroundColor: '#C3C7CA',
  },
  separatorText: {
    marginHorizontal: 10,
    fontSize: 14,
    color: '#6B7280',
    fontWeight: '500',
  },
  button1: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 15,
    marginTop: 20,
    backgroundColor: '#00B4D8',
    borderRadius: 10,
    justifyContent: 'center',
  },
  buttonText1: {
    color: 'white',
    fontSize: 18,
  },
  socialButtons: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginTop: 5,
  },
  button2: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 12,
    borderWidth: 1,
    borderColor: "#90E0EF",
    borderRadius: 10,
    width: '48%',
    justifyContent: 'center',
  },
  buttonText2: {
    marginLeft: 8,
    fontSize: 16,
    color: '#1F2937',
  },
});
