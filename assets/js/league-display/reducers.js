import {
  FETCH_LEAGUE,
  RECEIVE_LEAGUE
} from "./constants";

const initialState = {
  loading: true,
  league: null
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
          league: action.data.league,
          loading: false
        };
      } else {
        return state;
      }

    default:
      return state;
  }
}
