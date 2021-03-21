/* eslint-disable no-param-reassign */

import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';
import Routes from '../../packs/routes.js.erb';
import axios from '../../lib/axios.js';
import { mergeBelongsToForRecord } from '../../lib/merge_relationship.js';

const sendReview = createAsyncThunk('sendReview', async ({ whisky, review }, { rejectWithValue }) => {
  const url = Routes.api_whisky_reviews_path(whisky.id, { format: 'json' });
  try {
    const response = await axios.post(url, { review });
    return response.data;
  } catch (e) {
    return rejectWithValue(e.response.data);
  }
});

const slice = createSlice({
  name: 'review',
  initialState: {
    whiskey: {},
    reviews: [],
    tastes: {},
    hexColorsMap: {},
    showForm: false,
    review: {
      body: '',
      summary: '',
      taste: '',
      color: '',
      smokiness: '',
      errors: {},
    },
    sendingState: 'none',
  },
  reducers: {
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
    openForm(state) {
      state.showForm = true;
    },
  },
  extraReducers: (builder) => {
    builder.addCase(sendReview.pending, (state) => {
      state.sendingState = 'requested';
    })
      .addCase(sendReview.fulfilled, (state, { payload }) => {
        state.sendingState = 'success';
        state.showForm = false;
        const processedReview = mergeBelongsToForRecord(payload.data, payload.included);
        state.reviews = [processedReview, ...state.reviews];
        state.review = {
          body: '',
          summary: '',
          taste: '',
          color: '',
          smokiness: '',
          errors: {},
        };
      })
      .addCase(sendReview.rejected, (state, { payload }) => {
        const normalizedErrors = Object.keys(payload)
          .reduce((acc, key) => {
            acc[key] = payload[key].join(', ');
            return acc;
          }, {});

        state.errors = normalizedErrors;
        state.sendintState = 'failure';
      });
  },
});

export const actions = { ...slice.actions, sendReview };
export default slice.reducer;
