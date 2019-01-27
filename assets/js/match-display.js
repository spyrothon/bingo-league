import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import { h, render, Component } from 'preact';
import { Provider } from 'preact-redux';

import matchReducer from './match-display/reducers';
import { fetchMatch } from './match-display/actions';

import MatchContainer from "./match-display/containers/match-container";


const store = createStore(matchReducer, applyMiddleware(thunk));

document.addEventListener('DOMContentLoaded', () => {
  const container = document.querySelector("#match-display");
  const matchId = container.dataset.matchId;

  store.dispatch(fetchMatch(matchId));

  render(
    <Provider store={store}>
      <LeagueDisplayContainer />
    </Provider>,
    container
  );
});
