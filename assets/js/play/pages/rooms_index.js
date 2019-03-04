import { h, render, Component } from 'preact';
import { bindActionCreators } from 'redux';
import { connect } from 'preact-redux';
import {
  fetchRooms
} from '../actions';

import { RoomsContainer } from "../containers/rooms-container";

class RoomsIndex extends Component {
  componentDidMount() {
    this.props.fetchRooms();
  }

  render() {
    return (
      <RoomsContainer />
    );
  }
};


const mapStateToProps = () => { return {} };
const mapDispatchToProps = (dispatch) => {
  return {
    dispatch,
    ...bindActionCreators({
      fetchRooms
    }, dispatch)
  };
}

export const RoomsIndexPage = connect(mapStateToProps, mapDispatchToProps)(RoomsIndex);
