import { createSlice } from '@reduxjs/toolkit';

const slice = createSlice({
  name: 'review',
  initialState: {
    showForm: false,
    whiskey: {},
    reviews: []

  },
  reducers: {
    expandForm(state) {
      state.showForm = true
    }
  }
});

export const setupState = (gon) => (dispatch) => {
  const { lesson_version, lesson_member } = gon;
  dispatch(editorActions.changeContent({ content: lesson_version.prepared_code }));
  dispatch(solutionActions.setStartTime({ startTime: Date.now() }));
  const isFinished = lesson_member.state === lessonMemberStates.finished;
  if (isFinished) {
    dispatch(lessonActions.changeFinished({ finished: isFinished }));
    dispatch(solutionActions.changeSolutionProcessState({ processState: solutionStates.shown }));
  }
};
