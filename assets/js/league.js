import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import { h, render, Component } from 'preact';
import { Provider } from 'preact-redux';
import './fontawesome-library';

import leagueReducer from './league/reducers';
import {
  fetchMatches,
  fetchTeams
} from './league/actions';

import { App } from './league/app';

const store = createStore(leagueReducer, applyMiddleware(thunk));

document.addEventListener('DOMContentLoaded', () => {
  const container = document.querySelector("#league");

  store.dispatch(fetchMatches());
  store.dispatch(fetchTeams());

  render(
    <Provider store={store}>
      <App />
    </Provider>,
    container
  );
});
