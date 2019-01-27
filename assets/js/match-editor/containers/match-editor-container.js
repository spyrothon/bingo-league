import { connect } from 'preact-redux';
import { h, Component } from 'preact';
import { bindActionCreators } from 'redux';

import {
  addTeam,
  removeTeam,
  createMatch
} from '../actions';

import { MatchEditor } from '../components/match-editor';

const mapStateToProps = (state, ownProps) => {
  return {
    loading: state.loading,
    match: state.match,
    teams: state.teams
  };
};

const mapDispatchToProps = (dispatch) => {
  return {
    dispatch,
    ...bindActionCreators({
      onAddTeam: addTeam,
      onRemoveTeam: removeTeam,
      onCreateMatch: createMatch
    }, dispatch)
  };
};


export const MatchEditorContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(MatchEditor);
