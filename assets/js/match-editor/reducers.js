import dotProp from 'dot-prop-immutable';
import {
  ADD_PLAY,
  REMOVE_PLAY,
  FETCH_MATCH,
  RECEIVE_MATCH,
  FETCH_TEAMS,
  RECEIVE_TEAMS,
  SET_MATCH_INFO
} from "./constants";

const initialState = {
  loadingMatch: true,
  loadingTeams: true,
  match: {
    teams: [],
    plays: []
  },
  teams: []
};

export default function(state = initialState, action) {
  switch(action.type) {
    case FETCH_MATCH:
      return {
        ...state,
        loadingMatch: true
      }
    case RECEIVE_MATCH:
      return {
        ...state,
        loadingMatch: false,
        match: action.data.match
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
        teams: action.data.teams
      };

    case ADD_PLAY:
      const play = {
        team_id: parseInt(action.data.teamId),
        match_id: state.match.id,
        score: null,
        round: 1
      };
      return {
        ...state,
        match: {
          ...state.match,
          plays: [...state.match.plays, play]
        }
      };
    case REMOVE_PLAY:
      const teamId = action.data.teamId;
      return {
        ...state,
        match: {
          ...state.match,
          plays: state.match.plays.filter((play) => play.team_id != teamId)
        }
      };

    case SET_MATCH_INFO:
      return dotProp.set(state, action.data.property, action.data.value);

    default:
      return state;
  }
}
