import {
  FETCH_LEAGUE,
  RECEIVE_LEAGUE
} from "./constants";

const initialState = {
  loading: false,
  matchesById: {},
  playersById: {},
  teamsById: {}
};

export default function(state = initialState, action) {
  switch(action.type) {
    case FETCH_MATCH:
      return {
        ...state,
        loading: true
      }

    case RECEIVE_LEAGUE:
      if(action.data) {
        return {
          ...state,
          loading: false,
          matchesById: {},
          playersById: {},
          teamsById: {}
        };
      } else {
        return state;
      }

    default:
      return state;
  }
}
