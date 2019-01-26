import { h, Component } from 'preact';
import { bindActionCreators } from 'redux';
import { connect } from 'preact-redux';

import {
  createMatch
} from '../actions';

import LeagueDisplay from '../components/league-display';

const mapStateToProps = state => {
  return {
    loading:      state.loading,
    league:       state.league,
    matchesById:  state.matchesById,
    playersById:  state.playersById,
    playsById:    state.playsById,
    teamsById:    state.teamsById
  };
};

const mapDispatchToProps = (dispatch) => {
  return {
    dispatch,
    ...bindActionCreators({ createMatch }, dispatch)
  };
};


const LeagueDisplayContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(LeagueDisplay);

export default LeagueDisplayContainer;
