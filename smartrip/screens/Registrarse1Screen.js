import { StatusBar } from 'expo-status-bar';
import React, { useEffect, useState } from 'react';
import { StyleSheet, Text, View, TextInput, Pressable, TouchableOpacity, Platform, ScrollView, SafeAreaView } from 'react-native';
import * as SplashScreen from 'expo-splash-screen';
import { ImageBackground } from 'react-native';
import * as Font from 'expo-font';
import { useNavigation } from '@react-navigation/native';
import Stepper from './componentes/Stepper';
import Icon from 'react-native-vector-icons/MaterialIcons';
import DateTimePicker from '@react-native-community/datetimepicker';
import { Picker } from '@react-native-picker/picker';
import { FontAwesome } from '@expo/vector-icons';

export default function Registrarse1() {
  const navigation = useNavigation();
  const [persona, setPersona] = useState({
    nombre: '',
    apellido: '',
    fechaNacimiento: '',
    genero: '',
    email: '',
    telefono: '',
    contrasena: ''
  });

  const [errores, setErrores] = useState({
    nombre: '',
    apellido: '',
    fechaNacimiento: '',
    genero: '',
    email: '',
    telefono: '',
    contrasena: ''
  });

  const [mostrarPicker, setMostrarPicker] = useState(false);
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

  const onChangeFecha = (event, selectedDate) => {
    setMostrarPicker(Platform.OS === 'ios'); // mantener abierto en iOS
    if (selectedDate) {
      const formato = selectedDate.toLocaleDateString('es-AR');
      setFechaNacimiento(formato);
    }
  };

  const handleSubmit = () => {
    if (!nombre || !apellido || !fechaNacimiento || !genero) {
      alert("Por favor completá todos los campos.");
    } else {
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

        <Text style={styles.label}>Nombre</Text>
        <View style={styles.inputContainer}>
          <Icon name="person" size={20} color="#999" style={styles.icon} />
          <TextInput
            style={styles.input}
            placeholder="Ingresa tu nombre"
            value={nombre}
            onChangeText={setNombre}
          />
        </View>

        <Text style={styles.label}>Apellido</Text>
        <View style={styles.inputContainer}>
          <Icon name="person" size={20} color="#999" style={styles.icon} />
          <TextInput
            style={styles.input}
            placeholder="Ingresa tu apellido"
            value={apellido}
            onChangeText={setApellido}
          />
        </View>

        <Text style={styles.label}>Fecha de nacimiento</Text>
        <TouchableOpacity style={styles.inputContainer} onPress={() => setMostrarPicker(true)}>
          <Icon name="calendar-today" size={20} color="#999" style={styles.icon} />
          <Text style={{ paddingLeft: 10 }}>{fechaNacimiento || "mm/dd/yyyy"}</Text>
        </TouchableOpacity>

        {mostrarPicker && (
          <DateTimePicker
            value={new Date()}
            mode="date"
            display="default"
            onChange={onChangeFecha}
          />
        )}

        <Text style={styles.label}>Género</Text>
        <View style={styles.pickerContainer}>
          <Picker
            selectedValue={genero}
            onValueChange={(itemValue) => setGenero(itemValue)}
            style={styles.picker}
            dropdownIconColor="#000">
            <Picker.Item label="Seleccionar" value="" />
            <Picker.Item label="Hombre" value="hombre" />
            <Picker.Item label="Mujer" value="mujer" />
            <Picker.Item label="Prefiero no decirlo" value="no_decir" />
          </Picker>
        </View>

        <Pressable style={styles.button1} onPress={handleSubmit}>
          <Text style={styles.buttonText1}>Continuar</Text>
          <FontAwesome name="arrow-right" size={20} color="white" style={{ marginLeft: 10 }} />
        </Pressable>
        
        <View style={[styles.textContraseña, { padding: 15 }]}>
                <View style={styles.botones}>
                </View>
                <View style={styles.botones}>
                <Text style={styles.continuar}>O regístrate con</Text>
                </View>
                <View style={styles.botones}>
                </View>
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
    alignItems: 'center',
    paddingHorizontal: 20,
  },
  logoContainer: {
    marginTop: 60,
    alignItems: 'center',
  },
  image: {
    width: 200,
    height: 100,
  },
  textContraseña: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginTop: 10,
  },
  form: {
    width: '100%',
    marginTop: 30,
    padding: 20,
    borderRadius: 15,
    backgroundColor: 'rgba(202, 240, 248, 0.4)',
  },
  h1: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 5,
    color: '#000',
  },
  h2: {
    fontSize: 14,
    marginBottom: 15,
    color: '#6B7280',
  },
  label: {
    fontWeight: 'bold',
    marginTop: 10,
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
  icon: {
    marginRight: 10,
  },
  pickerContainer: {
    borderWidth: 2,
    borderColor: '#90E0EF',
    borderRadius: 10,
    overflow: 'hidden',
    backgroundColor: '#CAF0F8',
    marginVertical: 8,
  },
  picker: {
    height: 50,
    width: '100%',
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
  continuar: {
    textAlign: 'center',
    color: '#6B7280',
    marginVertical: 10,
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
