import { connect } from 'preact-redux';
import { h, Component } from 'preact';

import Match from '../components/match';

function getPlaysForMatch(plays, match) {
  return Object.values(plays).filter((p) => p.match_id == match.id);
}

function getTeamsFromPlays(teams, plays) {
  return plays.map((p) => teams[p.team_id]);
}


const mapStateToProps = (state, ownProps) => {
  const plays = getPlaysForMatch(state.playsById, ownProps.match);
  return {
    plays: plays,
    teams: getTeamsFromPlays(state.teamsById, plays)
  };
};

const mapDispatchToProps = (dispatch) => {
  return {
    dispatch
  };
};


const MatchContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(Match);

export default MatchContainer;
