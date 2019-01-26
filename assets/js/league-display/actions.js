import {
  FETCH_LEAGUE,
  RECEIVE_LEAGUE
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
}

export function receiveLeague(league) {
  return {
    type: RECEIVE_LEAGUE,
    data: {
      league: league
    }
  };
}


function checkStatus(response) {
  if (response.status >= 200 && response.status < 300 || response.status == 422) {
    return response;
  } else {
    throw response;
  }
}

function parseJSON(response) {
  return response.json();
}
