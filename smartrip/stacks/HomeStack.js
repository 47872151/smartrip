import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { Ionicons } from '@expo/vector-icons';
import { Feather } from '@expo/vector-icons'; 
import FontAwesome from '@expo/vector-icons/FontAwesome';
import HomeTab from '../tabs/HomeTab';
import ActividadTab from '../tabs/ActividadTab';
import CuentaTab from '../tabs/CuentaTab';
import PremiumTab from '../tabs/PremiumTab';

const Tab = createBottomTabNavigator();

export default function HomeStack() {
  return (
    <Tab.Navigator
      initialRouteName="Home"
      screenOptions={({ route }) => ({
        tabBarIcon: ({ color, size }) => {
          if (route.name === 'Actividad') {
            return <Feather name="activity" size={size} color={color} />;
          }
          if (route.name === 'Cuenta'){
            return <FontAwesome name="user-circle" size={size} color={color} />
          }
          let iconName;
          if (route.name === 'Home') iconName = 'home';
          else if (route.name === 'Premium') iconName = 'star';
          return <Ionicons name={iconName} size={size} color={color} />;
        },
        tabBarActiveTintColor: '#00B4D8',
        tabBarInactiveTintColor: '#90E0EF',
        tabBarStyle: {
          backgroundColor: "rgba(202, 240, 248, 0.4)",
          borderTopLeftRadius: 15,
          borderTopRightRadius: 15,
          height: 80, 
          paddingBottom: 10,
        },
      })}
    >
      <Tab.Screen name="Home" component={HomeTab} />
      <Tab.Screen name="Actividad" component={ActividadTab} />
      <Tab.Screen name="Cuenta" component={CuentaTab} />
      <Tab.Screen name="Premium" component={PremiumTab} />
    </Tab.Navigator>
  );
}
