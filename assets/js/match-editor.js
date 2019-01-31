import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import { h, render, Component } from 'preact';
import { Provider } from 'preact-redux';
import './fontawesome-library';

import matchReducer from './match-editor/reducers';
import {
  fetchMatch,
  fetchTeams
} from './match-editor/actions';

import { MatchEditorContainer } from "./match-editor/containers/match-editor-container";


const store = createStore(matchReducer, applyMiddleware(thunk));

document.addEventListener('DOMContentLoaded', () => {
  const container = document.querySelector("#match-editor");
  const matchId = container.dataset.matchId || "new";

  store.dispatch(fetchMatch(matchId));
  store.dispatch(fetchTeams());

  render(
    <Provider store={store}>
      <MatchEditorContainer />
    </Provider>,
    container
  );
});
