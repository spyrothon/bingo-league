import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import { h, render, Component } from 'preact';
import { Provider } from 'preact-redux';
import './fontawesome-library';

import { TWITCH_CHANNEL } from './league/constants';
import leagueReducer from './league/reducers';
import {
  fetchMatches,
  fetchTeams,
  fetchChannelStatus
} from './league/actions';

import { App } from './league/app';


const store = createStore(leagueReducer, applyMiddleware(thunk));

document.addEventListener('DOMContentLoaded', () => {
  const container = document.querySelector("#league");

  function updateAllData() {
    store.dispatch(fetchChannelStatus(TWITCH_CHANNEL));
    store.dispatch(fetchMatches());
    store.dispatch(fetchTeams());
  }
  // Set all data to automatically refresh every 2 minutes.
  setInterval(updateAllData, 2 * 60 * 1000);
  updateAllData();

  render(
    <Provider store={store}>
      <App />
    </Provider>,
    container
  );
});
