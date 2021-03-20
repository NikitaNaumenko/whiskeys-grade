/* eslint-disable no-param-reassign */

import { createSlice } from '@reduxjs/toolkit';
import Routes from '../../packs/routes.js.erb';
import axios from '../../lib/axios.js';

const slice = createSlice({
  name: 'review',
  initialState: {
    whiskey: {},
    reviews: [],
    tastes: {},
    hexColorsMap: {},
    review: {
      body: '',
      summary: '',
      taste: '',
      color: '',
      smokiness: '',
      errors: {}
    },
    sendingState: 'none',
  },
  reducers: {
    submitReviewRequest(state) {
      state.errors = {};
      state.sendingState = 'requested';
    },
    submitReviewSuccess(state) {
      state.sendingState = 'success';
    },
    submitReviewFailure(state, { payload }) {
      console.log(payload)
      const normalizedErrors = Object.keys(payload.errors)
        .reduce((acc, key) => {
          acc[key] = payload.errors[key].join(', ');
          return acc;
        }, {});

      state.errors = normalizedErrors;
      state.sendintState = 'failure';
    },

    changeBody(state, { payload }) {
      state.review.body = payload.reviewBody;
    },
    changeSummary(state, { payload }) {
      state.review.summary = payload.summary;
    },
    changeTaste(state, { payload }) {
      const pickedTaste = Object.keys(state.tastes).find((taste) => state.tastes[taste] === payload.taste);
      state.review.taste = pickedTaste;
    },
    changeColor(state, { payload }) {
      const pickedColor = Object.keys(state.hexColorsMap)
        .find((color) => state.hexColorsMap[color].toLowerCase() === payload.color.toLowerCase());
      state.review.color = pickedColor;
    },
    changeSmokiness(state, { payload }) {
      state.review.smokiness = payload.smokiness;
    },
  },
});

const sendReview = (whisky, review) => async (dispatch) => {
  const url = Routes.api_whisky_reviews_path(whisky.id, { format: 'json' });
  const { submitReviewRequest, submitReviewSuccess, submitReviewFailure } = slice.actions;

  try {
    dispatch(submitReviewRequest());
    await axios.post(url, { review });
    dispatch(submitReviewSuccess());
  } catch (e) {
    dispatch(submitReviewFailure({ errors: e.response.data }));
    throw e;
  }
};

export const actions = { ...slice.actions, sendReview };
export default slice.reducer;
