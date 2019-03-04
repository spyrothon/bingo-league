import { h, render, Component } from 'preact';
import { bindActionCreators } from 'redux';
import { connect } from 'preact-redux';
import {
  fetchRoom
} from '../actions';

class RoomsShow extends Component {
  componentDidMount() {
    const { fetchRoom, roomId } = this.props;
    fetchRoom(roomId);
  }

  render() {
    const {
      loading,
      room
    } = this.props;

    if(loading) return <p>Loading</p>;

    return (
      <h1>{room.name}</h1>
    );
  }
};


const mapStateToProps = (state, ownProps) => {
  return {
    loading: state.loading,
    room: state.roomsById[ownProps.roomId]
  };
};
const mapDispatchToProps = (dispatch) => {
  return {
    dispatch,
    ...bindActionCreators({
      fetchRoom
    }, dispatch)
  };
};

export const RoomsShowPage = connect(mapStateToProps, mapDispatchToProps)(RoomsShow);
