import {
  FETCH_MATCHES,
  FETCH_TEAMS,
  RECEIVE_MATCHES,
  RECEIVE_TEAMS
} from './constants';

const defaultHeaders = {
  'Accept': 'application/json',
  'Content-Type': 'application/json',
  'x-expires': window.expiration
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
