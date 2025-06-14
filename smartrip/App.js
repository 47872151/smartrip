import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import LoginScreen from './screens/LoginScreen';
import HomeStack from './stacks/HomeStack';
import RegistrarseStack from './stacks/RegistrarseStack';
//import uberRoutes from './routes/uber.js';
//app.use('/apis/UberAPI', uberRoutes);
const RootStack = createNativeStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <RootStack.Navigator initialRouteName="Login" screenOptions={{ headerShown: false }}>
        <RootStack.Screen name="Login" component={LoginScreen} />
        <RootStack.Screen name="HomeStack" component={HomeStack} />
        <RootStack.Screen name="RegistrarseStack" component={RegistrarseStack} />
      </RootStack.Navigator>
    </NavigationContainer>
  );
}
