import {
  FETCH_LEAGUE,
  RECEIVE_LEAGUE,
  CREATE_MATCH
} from './constants';

const defaultHeaders = {
  'Accept': 'application/json',
  'Content-Type': 'application/json',
  'Authorization': `Bearer ${window.userToken}`,
  'x-expires': window.expiration
};


export function fetchLeague(leagueId) {
  return dispatch => {
    fetch(`/api/leagues/${leagueId}`, { headers: defaultHeaders })
      .then(checkStatus)
      .then(parseJSON)
      .then((response) => {
        return dispatch(receiveLeague(response));
      });
  };
};

export function receiveLeague(data) {
  return {
    type: RECEIVE_LEAGUE,
    data: data
  };
};

export function createMatch(matchData) {
  console.log(matchData);
  return dispatch => {
    fetch('/api/matches/create', {
      headers: defaultHeaders,
      method: 'POST',
      body: JSON.stringify(matchData)
    })
    .then(checkStatus)
    .then(parseJSON)
    .then((response) => {
      return dispatch(fetchLeague(matchData.league_id));
    });
  };
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
