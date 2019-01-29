import { connect } from 'preact-redux';
import { h, Component } from 'preact';

import { Standings } from '../components/standings';

const mapStateToProps = (state, ownProps) => {
  return {
    loading: state.loadingMatches || state.loadingTeams,
    matches: state.matches,
    allTeams: state.allTeams
  };
};

const mapDispatchToProps = (dispatch) => {
  return {
    dispatch
  };
};


export const StandingsContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(Standings);
