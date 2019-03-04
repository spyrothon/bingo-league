import _ from 'lodash';
import {
  FETCH_ROOMS,
  RECEIVE_ROOMS,
} from "./constants";

const initialState = {
  roomsById: {},
  loading: true
};

export default function(state = initialState, action) {
  switch(action.type) {
    case FETCH_ROOMS:
      return {
        ...state,
        loading: true
      };

    case RECEIVE_ROOMS:
      const newRoomsById = _.keyBy(action.data.rooms, 'room_id');

      return {
        ...state,
        loading: false,
        roomsById: {
          ...state.roomsById,
          ...newRoomsById
        }
      };



    default:
      return state;
  }
}
