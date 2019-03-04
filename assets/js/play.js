import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import { h, render, Component } from 'preact';
import { Provider } from 'preact-redux';
import { Router } from 'preact-router';
import './fontawesome-library';

import playReducer from './play/reducers';
const store = createStore(playReducer, applyMiddleware(thunk));


import { RoomsIndexPage } from "./play/pages/rooms_index";
import { RoomsShowPage } from "./play/pages/rooms_show";


document.addEventListener('DOMContentLoaded', () => {
  const container = document.querySelector("#play-container");
  const matchId = container.dataset.matchId || "new";

  render(
    <Provider store={store}>
      <Router>
        <RoomsIndexPage path="/play" />
        <RoomsShowPage path="/play/:roomId" />
      </Router>
    </Provider>,
    container
  );
});
