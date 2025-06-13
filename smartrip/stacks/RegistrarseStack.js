import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import Registrarse1Tab from '../tabs/Registrarse1Tab';
import Registrarse2Tab from '../tabs/Registrarse2Tab';
import Registrarse3Tab from '../tabs/Registrarse3Tab';

const Tab = createBottomTabNavigator();

export default function RegistrarseStack() {
  return (
    <Tab.Navigator   screenOptions={{
        headerShown: false, // Oculta la cabecera también si no la querés
        tabBarStyle: { display: 'none' }, // OCULTA la barra
      }}>
      <Tab.Screen name="Registrarse1" component={Registrarse1Tab} />
      <Tab.Screen name="Registrarse2" component={Registrarse2Tab} />
      <Tab.Screen name="Registrarse3" component={Registrarse3Tab} />
    </Tab.Navigator>
  );
}
