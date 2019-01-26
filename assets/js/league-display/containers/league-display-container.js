import { connect } from 'preact-redux';
import { h, Component } from 'preact';

import LeagueDisplay from '../components/league-display';

const mapStateToProps = state => {
  return {
    league: state.league,
    loading: state.loading
  };
};

const mapDispatchToProps = dispatch => {
  return {};
};


const LeagueDisplayContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(LeagueDisplay);

export default LeagueDisplayContainer;
