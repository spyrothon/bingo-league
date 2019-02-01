import { connect } from 'preact-redux';
import { h, Component } from 'preact';

import { League } from '../components/league';

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


export const LeagueContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(League);
