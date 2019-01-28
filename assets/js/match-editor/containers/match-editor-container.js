import { connect } from 'preact-redux';
import { h, Component } from 'preact';
import { bindActionCreators } from 'redux';

import {
  addPlay,
  removePlay,
  createMatch,
  updateMatch,
  setMatchInfo
} from '../actions';

import { MatchEditor } from '../components/match-editor';

const mapStateToProps = (state, ownProps) => {
  return {
    loading: state.loadingMatch || state.loadingTeams,
    match: state.match,
    teams: state.teams
  };
};

const mapDispatchToProps = (dispatch) => {
  return {
    dispatch,
    ...bindActionCreators({
      onAddPlay: addPlay,
      onRemovePlay: removePlay,
      onCreateMatch: createMatch,
      onUpdateMatch: updateMatch,
      onSetMatchInfo: setMatchInfo
    }, dispatch)
  };
};


export const MatchEditorContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(MatchEditor);
