import {
  ADD_TEAM,
  REMOVE_TEAM,
  FETCH_MATCH,
  RECEIVE_MATCH,
  RECEIVE_TEAMS
} from "./constants";

const initialState = {
  loading: false,
  match: {
    teams: []
  },
  teams: []
};

export default function(state = initialState, action) {
  switch(action.type) {
    case FETCH_MATCH:
      return {
        ...state,
        loading: true
      }

    case RECEIVE_MATCH:
      if(action.data) {
        return {
          ...state,
          loading: false,
          match: action.data.match
        };
      } else {
        return state;
      }

    case RECEIVE_TEAMS:
      if(action.data) {
        return {
          ...state,
          teams: action.data.teams
        };
      } else {
        return state;
      }

    case ADD_TEAM:
      const team = state.teams.find((team) => team.id == action.data.teamId);
      if(team) {
        return {
          ...state,
          match: {
            ...state.match,
            teams: [...state.match.teams, team]
          }
        };
      } else {
        return state;
      }

    case REMOVE_TEAM:
      const teamId = action.data.teamId;
      if(teamId) {
        return {
          ...state,
          match: {
            ...state.match,
            teams: state.match.teams.filter((team) => team.id != teamId)
          }
        };
      } else {
        return state;
      }

    default:
      return state;
  }
}
