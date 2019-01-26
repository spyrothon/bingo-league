import { createStore } from 'redux';
import leagueReducer from './reducers';
import * from './actions';

const store = createStore(leagueReducer);

const unsubscribe = store.subscribe(() => console.log(store.getState()));

// store.dispatch(fetchLeague(1));
