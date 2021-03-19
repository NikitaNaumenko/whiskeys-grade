import React from 'react';
import ReactDOM from 'react-dom';
import { configureStore } from '@reduxjs/toolkit';
import { Provider } from 'react-redux';
import Review from './components/Review';
import reducer, { setupState } from './slices/index.js';

export default () => {
  const store = configureStore({
    reducer,
  });
  store.dispatch(setupState(gon));

  ReactDOM.render(
    <Provider store={store}>
      <Review />
    </Provider>,
    document.querySelector('#reviews-container'),
  );
}
