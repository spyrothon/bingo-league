import { connect } from 'preact-redux';
import { h, Component } from 'preact';

import Team from '../components/team-standings';

function getPlayersForTeam(players, team) {
  Object.values(players).filter((p) => p.team_id == team.id);
}

const mapStateToProps = (state, ownProps) => {
  return {
    players: getPlayersForTeam(state.playersById, ownProps.team)
  };
};

const mapDispatchToProps = (dispatch) => {
  return {
    dispatch
  };
};


const TeamContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(Team);

export default TeamContainer;
