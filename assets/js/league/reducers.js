import _ from 'lodash';
import dotProp from 'dot-prop-immutable';
import {
  FETCH_MATCHES,
  RECEIVE_MATCHES,
  FETCH_TEAMS,
  RECEIVE_TEAMS,
  FETCH_CHANNEL_STATUS,
  RECEIVE_CHANNEL_STATUS
} from "./constants";

const initialState = {
  loadingMatches: true,
  loadingTeams: true,
  loadingChannelStatus: true,
  matches: [],
  allTeams: {},
  twitchChannels: {}
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

    case FETCH_CHANNEL_STATUS:
      return {
        ...state,
        loadingChannelStatus: true
      };
    case RECEIVE_CHANNEL_STATUS:
      const channelData = _.keyBy(action.data, (data) => data.user_name.toLowerCase());
      return {
        ...state,
        twitchChannels: {
          ...state.twitchChannels,
          ...channelData
        }
      };

    default:
      return state;
  }
}
