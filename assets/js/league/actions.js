import {
  FETCH_MATCHES,
  RECEIVE_MATCHES,
  FETCH_TEAMS,
  RECEIVE_TEAMS,
  FETCH_CHANNEL_STATUS,
  RECEIVE_CHANNEL_STATUS
} from './constants';

const defaultHeaders = {
  'Accept': 'application/json',
  'Content-Type': 'application/json',
  'x-expires': window.expiration
};

const twitchHeaders = {
  'Accept': 'application/json',
  'Content-Type': 'application/json',
  'Client-ID': 'evlfk8nv841bnxba71g9837vyjh51q'
};


export function fetchTeams() {
  return dispatch => {
    fetch(`/api/teams`, {
      headers: defaultHeaders,
      method: 'GET'
    })
    .then(checkStatus)
    .then(parseJSON)
    .then((response) => {
      return dispatch(receiveTeams(response.data));
    });
  };
}


export function fetchMatches() {
  return dispatch => {
    fetch(`/api/matches`, {
      headers: defaultHeaders,
      method: 'GET'
    })
    .then(checkStatus)
    .then(parseJSON)
    .then((response) => {
      return dispatch(receiveMatches(response.data));
    });
  };
}

export function fetchChannelStatus(channel) {
  return dispatch => {
    fetch(`https://api.twitch.tv/helix/streams?user_login=${channel}`, {
      headers: twitchHeaders,
      method: 'GET'
    })
    .then(checkStatus)
    .then(parseJSON)
    .then((response) => {
      return dispatch(receiveChannelStatus(channel, response.data));
    });
  }
}


export function receiveTeams(data) {
  return {
    type: RECEIVE_TEAMS,
    data: data
  }
}

export function receiveMatches(data) {
  return {
    type: RECEIVE_MATCHES,
    data: data
  }
}

export function receiveChannelStatus(channel, data) {
  return {
    type: RECEIVE_CHANNEL_STATUS,
    channel: channel,
    data: data
  }
}


function checkStatus(response) {
  if (response.status >= 200 && response.status < 300 || response.status == 422) {
    return response;
  } else {
    throw response;
  }
};

function parseJSON(response) {
  return response.json();
};
