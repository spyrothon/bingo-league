import {
  FETCH_MATCH,
  RECEIVE_MATCH
} from './constants';

const defaultHeaders = {
  'Accept': 'application/json',
  'Content-Type': 'application/json',
  'x-expires': window.expiration
};

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
      return dispatch(receiveMatch(response.data));
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
