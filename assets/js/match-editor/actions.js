import {
  ADD_PLAY,
  FETCH_MATCH,
  FETCH_TEAMS,
  RECEIVE_MATCH,
  RECEIVE_TEAMS,
  REMOVE_PLAY,
  SET_MATCH_INFO
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


export function fetchMatch(matchId) {
  return dispatch => {
    fetch(`/api/matches/${matchId}`, {
      headers: defaultHeaders,
      method: 'GET'
    })
    .then(checkStatus)
    .then(parseJSON)
    .then((response) => {
      return dispatch(receiveMatch(response.data));
    });
  };
}

export function createMatch(matchData) {
  return dispatch => {
    fetch('/api/matches/create', {
      headers: defaultHeaders,
      method: 'POST',
      body: JSON.stringify(matchData)
    })
    .then(checkStatus)
    .then(parseJSON)
    .then((response) => {
      const matchId = response.data.match.id;
      window.location.href = `/matches/${matchId}/edit`;
    });
  };
}

export function updateMatch(matchData) {
  return dispatch => {
    fetch(`/api/matches/${matchData.id}/update`, {
      headers: defaultHeaders,
      method: 'POST',
      body: JSON.stringify(matchData)
    })
    .then(checkStatus)
    .then(parseJSON)
    .then((response) => {
      return dispatch(receiveMatch(response.data));
    });
  };
}


export function receiveTeams(data) {
  return {
    type: RECEIVE_TEAMS,
    data: data
  }
}

export function addPlay(teamId) {
  return {
    type: ADD_PLAY,
    data: {
      teamId
    }
  }
}

export function removePlay(teamId) {
  return {
    type: REMOVE_PLAY,
    data: {
      teamId
    }
  }
}

export function receiveMatch(data) {
  return {
    type: RECEIVE_MATCH,
    data: data
  }
}

export function setMatchInfo(property, value) {
  return {
    type: SET_MATCH_INFO,
    data: {
      property,
      value
    }
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
