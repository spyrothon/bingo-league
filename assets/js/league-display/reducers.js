import {
  FETCH_LEAGUE,
  RECEIVE_LEAGUE
} from "./constants";

const initialState = {
  loading: true,
  league: null,
  matchesById: {},
  playersById: {},
  playsById: {},
  teamsById: {}
};

export default function(state = initialState, action) {
  switch(action.type) {
    case FETCH_LEAGUE:
      return {
        ...state,
        loading: true
      }

    case RECEIVE_LEAGUE:
      if(action.data) {
        return {
          ...state,
          loading:      false,
          league:       action.data.league,
          matchesById:  action.data.matches,
          playersById:  action.data.players,
          playsById:    action.data.plays,
          teamsById:    action.data.teams,
        };
      } else {
        return state;
      }

    default:
      return state;
  }
}
