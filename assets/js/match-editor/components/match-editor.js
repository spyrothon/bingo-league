import { h, Component } from 'preact';
import { renderJoined } from '../util';
import { DateTime } from 'luxon';
import linkState from 'linkstate';

import DateTimePicker from '../../ext/preact-flatpickr';

export class MatchEditor extends Component {
  constructor(props) {
    super();

    this.state = {
      teamToAdd: null
    }
  }

  addTeam() {
    const { onAddTeam } = this.props;
    const { teamToAdd } = this.state;

    onAddTeam(teamToAdd);
    this.setState({
      teamToAdd: null
    });
  }

  removeTeam(teamId) {
    const { onRemoveTeam } = this.props;
    onRemoveTeam(teamId);
  }

  createMatch() {
    const { match, onCreateMatch } = this.props;
    onCreateMatch(match);
  }

  render(props, state) {
    const {
      loading,
      match,
      teams,
      onCreateMatch,
      onAddTeam,
      onRemoveTeam
    } = props;
    const {
      teamToAdd
    } = state;

    const matchTeams = match.teams;
    const matchTeamIds = matchTeams.map((t) => t.id);
    const remainingTeams = teams.filter((team) => !matchTeamIds.includes(team.id));


    return (
      <div>
        <input
          class="input title is-4 is-content"
          placeholder="Edit Match Name"
          value={match.name}
          onChange={linkState(this, 'match.start_date')}
        />

        <div class="columns">
          <div class="column is-4-desktop">
            <div class="box">
              <h2 class="title is-4">Information</h2>

              <div class="field">
                <label class="label">Date</label>
                <div class="control">
                  <DateTimePicker
                    data-enable-time
                    class="input"
                    value={match.start_date}
                    onChange={linkState(this, 'match.start_date')}
                  />
                </div>
              </div>

              <div class="has-margin-top-lg">
                <a class="button is-fullwidth is-primary" onClick={this.createMatch.bind(this)}>
                  Create Match
                </a>
              </div>
            </div>
          </div>

          <div class="column is-8-desktop">
            <div class="box">
              <h2 class="title is-4">Teams</h2>

              <table class="table is-fullwidth">
                <thead>
                  <tr>
                    <th>Team</th>
                    <th>Score</th>
                    <th></th>
                  </tr>
                </thead>

                <tbody>
                  { matchTeams.map((team) => {
                      return (
                        <tr key={team.id}>
                          <td>{team.name}</td>
                          <td>
                            <input
                              type="number"
                              placeholder="Enter Score"
                              class="input is-content"
                            />
                          </td>
                          <td>
                            <a class="button is-white" onClick={this.removeTeam.bind(this, team.id)}>
                              &#x2716;
                            </a>
                          </td>
                        </tr>
                      );
                    })
                  }
                </tbody>
              </table>

              <div class="field is-grouped">
                <div class="control">
                  <div class="select">
                    <select value={teamToAdd} onChange={linkState(this, 'teamToAdd')}>
                      <option value="" disabled>Select a Team</option>
                      { remainingTeams.map((team) => {
                          return <option value={team.id}>{team.name}</option>
                        })
                      }
                    </select>
                  </div>
                </div>

                <div class="control">
                  <button class="button is-primary" onClick={this.addTeam.bind(this)} disabled={!teamToAdd}>Add Team</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
};
