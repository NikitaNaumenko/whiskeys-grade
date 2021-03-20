import React from 'react';
import ReactDOM from 'react-dom';
import { configureStore } from '@reduxjs/toolkit';
import { Provider } from 'react-redux';
import gon from 'gon';
import Review from './components/Review';
import reducer from './slices/index.js';

export default () => {
  console.log(gon);
  const preloadedState = {
    whisky: gon.whisky.data.attributes,
    reviews: gon.reviews.data.map((r) => r.attributes),
    hexColorsMap: gon.whisky_colors,
    tastes: gon.tastes,
    review: {
      body: '',
      summary: '',
      taste: '',
      color: '',
      smokiness: '',
    },
  };
  const store = configureStore({ reducer, preloadedState });

  ReactDOM.render(
    <Provider store={store}>
      <Review />
    </Provider>,
    document.querySelector('#reviews-container'),
  );
};
