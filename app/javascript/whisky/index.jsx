import React from 'react';
import ReactDOM from 'react-dom';
import { configureStore } from '@reduxjs/toolkit';
import { Provider } from 'react-redux';
import gon from 'gon';
import ReviewContainer from './components/ReviewContainer';
import reducer from './slices/index.js';
import { mergeBelongsToForRecords } from '../lib/merge_relationship';

export default () => {
  const preloadedState = {
    whisky: gon.whisky.data.attributes,
    reviews: mergeBelongsToForRecords(gon.reviews),
    hexColorsMap: gon.whisky_colors,
    tastes: gon.tastes,
    showForm: false,
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
      <ReviewContainer />
    </Provider>,
    document.querySelector('#reviews-container'),
  );
};
