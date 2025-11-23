/**
 * CareConnect Health App
 * Main Application Component
 */
import React from 'react';
import {StatusBar} from 'react-native';
import {Provider} from 'react-redux';
import {store} from './store';
import {RootNavigator} from './navigation/RootNavigator';
import './config/i18n';

const App = () => {
  return (
    <Provider store={store}>
      <StatusBar barStyle="dark-content" backgroundColor="#FFFFFF" />
      <RootNavigator />
    </Provider>
  );
};

export default App;
