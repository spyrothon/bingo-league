import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import { h, render, Component } from 'preact';
import { Provider } from 'preact-redux';
import './fontawesome-library';

import standingsReducer from './standings/reducers';
import {
  fetchMatches,
  fetchTeams
} from './standings/actions';

import { StandingsContainer } from "./standings/containers/standings-container";


const store = createStore(standingsReducer, applyMiddleware(thunk));

document.addEventListener('DOMContentLoaded', () => {
  const container = document.querySelector("#standings");

  store.dispatch(fetchMatches());
  store.dispatch(fetchTeams());

  render(
    <Provider store={store}>
      <StandingsContainer />
    </Provider>,
    container
  );
});
