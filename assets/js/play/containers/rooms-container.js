import { connect } from 'preact-redux';
import { h, Component } from 'preact';
import { bindActionCreators } from 'redux';

import {
} from '../actions';

import { RoomList } from '../components/room-list';

const mapStateToProps = (state, ownProps) => {
  return {
    loading: state.loading,
    roomsById: state.roomsById
  };
};

const mapDispatchToProps = (dispatch) => {
  return {
    dispatch,
    ...bindActionCreators({
    }, dispatch)
  };
};


export const RoomsContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(RoomList);
