import {
  RECEIVE_ROOMS
} from './constants';

const defaultHeaders = {
  'Accept': 'application/json',
  'Content-Type': 'application/json'
};


export function fetchRooms() {
  return dispatch => {
    fetch(`/api/rooms`, {
      headers: defaultHeaders,
      method: 'GET'
    })
    .then(checkStatus)
    .then(parseJSON)
    .then((response) => {
      return dispatch(receiveRooms(response.data.rooms));
    });
  };
}


export function fetchRoom(roomId) {
  return dispatch => {
    fetch(`/api/rooms/${roomId}`, {
      headers: defaultHeaders,
      method: 'GET'
    })
    .then(checkStatus)
    .then(parseJSON)
    .then((response) => {
      return dispatch(receiveRooms([response.data.room]));
    });
  };
}

export function createRoom(roomData) {
  return dispatch => {
    fetch('/api/rooms', {
      headers: defaultHeaders,
      method: 'POST',
      body: JSON.stringify(roomData)
    })
    .then(checkStatus)
    .then(parseJSON)
    .then((response) => {
      return dispatch(receiveRooms([response.data.room]));
    });
  };
}


export function receiveRooms(data) {
  return {
    type: RECEIVE_ROOMS,
    data: {
      rooms: data
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
