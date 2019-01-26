import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import { h, render, Component } from 'preact';
import { Provider } from 'preact-redux';

import leagueReducer from './league-display/reducers';
import { fetchLeague } from './league-display/actions';

import LeagueDisplayContainer from "./league-display/containers/league-display-container";


const store = createStore(leagueReducer, applyMiddleware(thunk));

document.addEventListener('DOMContentLoaded', () => {
  const container = document.querySelector("#league-display");
  const leagueId = container.dataset.leagueId;

  store.dispatch(fetchLeague(leagueId));

  render(
    <Provider store={store}>
      <LeagueDisplayContainer />
    </Provider>,
    container
  );
});
