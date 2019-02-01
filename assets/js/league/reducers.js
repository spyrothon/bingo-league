import _ from 'lodash';
import dotProp from 'dot-prop-immutable';
import {
  FETCH_MATCHES,
  RECEIVE_MATCHES,
  FETCH_TEAMS,
  RECEIVE_TEAMS
} from "./constants";

const initialState = {
  loadingMatches: true,
  loadingTeams: true,
  matches: [],
  allTeams: {}
};

export default function(state = initialState, action) {
  switch(action.type) {
    case FETCH_MATCHES:
      return {
        ...state,
        loadingMatches: true
      }
    case RECEIVE_MATCHES:
      return {
        ...state,
        loadingMatches: false,
        matches: action.data.matches
      };

    case FETCH_TEAMS:
      return {
        ...state,
        loadingTeams: true
      }
    case RECEIVE_TEAMS:
      return {
        ...state,
        loadingTeams: false,
        allTeams: _.keyBy(action.data.teams, 'id')
      };

    default:
      return state;
  }
}
