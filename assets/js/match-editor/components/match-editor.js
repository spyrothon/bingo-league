import { h, Component } from 'preact';
import { renderJoined } from '../util';
import { DateTime } from 'luxon';
import linkState from 'linkstate';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

import DateTimePicker from '../../ext/preact-flatpickr';


export class MatchEditor extends Component {
  constructor(props) {
    super();

    this.state = {
      teamToAdd: null
    }
  }

  addPlay() {
    const { onAddPlay } = this.props;
    const { teamToAdd } = this.state;

    onAddPlay(teamToAdd);
    this.setState({
      teamToAdd: null
    });
  }

  removePlay(playId) {
    const { onRemovePlay } = this.props;
    onRemovePlay(playId);
  }

  saveMatch() {
    const { match, onCreateMatch, onUpdateMatch } = this.props;
    if(match.id) {
      onUpdateMatch(match);
    } else {
      onCreateMatch(match);
    }
  }

  confirmDeleteMatch() {
    const { match } = this.props;
    if (window.confirm(`Confirm deletion of match "${match.name}"?`)) {
      window.location.href = `/matches/${match.id}/delete`;
    }
  }

  render(props, state) {
    const {
      loading,
      match,
      teams,
      onCreateMatch,
      onUpdateMatch,
      onAddPlay,
      onRemovePlay,
      onSetMatchInfo
    } = props;
    const {
      teamToAdd
    } = state;

    const { plays, name, is_featured, is_finalized, is_public } = match;
    const teamIds = plays.map((p) => p.team_id);
    const remainingTeams = teams.filter((team) => !teamIds.includes(team.id));
    const isExisting = !!match.id;

    if(loading) return <h1>Loading</h1>;

    const canSubmit = match.name && match.start_date;

    return (
      <div>
        <input
          class="input is-size-4 is-content"
          placeholder="Edit Match Name"
          value={name}
          onInput={(e) => onSetMatchInfo('match.name', e.target.value)}
        />

        <div class="has-margin-top-sm has-margin-bottom-md">
          <label class="label">
            <input
              type="checkbox"
              name="is_featured"
              checked={is_featured}
              onChange={(e) => onSetMatchInfo('match.is_featured', e.target.checked)}
            /> This match will be featured on stream.
          </label>
          <label class="label">
            <input
              type="checkbox"
              name="is_public"
              checked={is_public}
              onChange={(e) => onSetMatchInfo('match.is_public', e.target.checked)}
            /> This match is publicly visible.
          </label>
        </div>


        <div class="columns">
          <div class="column is-4-desktop">
            <div class="box">
              <h2 class="title is-4">Information</h2>

              <div class="field">
                <label class="label">Date (local time)</label>
                <div class="control">
                  <DateTimePicker
                    data-enable-time
                    class="input is-content"
                    value={match.start_date}
                    onChange={([value]) => onSetMatchInfo('match.start_date', value)}
                  />
                </div>
              </div>

              <div class="field">
                <label class="label">Description (public)</label>
                <div class="control">
                  <textarea
                    class="textarea"
                    value={match.description}
                    onInput={(e) => onSetMatchInfo('match.description', e.target.value)}
                  />
                </div>
              </div>

              <div class="field">
                <label class="label">Notes (private)</label>
                <div class="control">
                  <textarea
                    class="textarea"
                    value={match.notes}
                    onInput={(e) => onSetMatchInfo('match.notes', e.target.value)}
                  />
                </div>
              </div>

              <div class="field">
                <label class="label">Video Link</label>
                <div class="control">
                  <input
                    class="input is-content"
                    value={match.video_link}
                    onInput={(e) => onSetMatchInfo('match.video_link', e.target.value)}
                  />
                </div>
              </div>

              <div class="field">
                <label class="label">Room Link</label>
                <div class="control">
                  <input
                    class="input is-content"
                    value={match.room_link}
                    onInput={(e) => onSetMatchInfo('match.room_link', e.target.value)}
                  />
                </div>
              </div>

              <div class="field">
                <label class="label">Board Image</label>
                <div class="control">
                  <input
                    class="input is-content"
                    value={match.board_image_link}
                    onInput={(e) => onSetMatchInfo('match.board_image_link', e.target.value)}
                  />
                </div>
              </div>

              <div class="has-margin-top-lg">
                <a class="button is-fullwidth is-primary" onClick={this.saveMatch.bind(this)} disabled={!canSubmit}>
                  Save Match
                </a>
              </div>
            </div>

            { isExisting &&
              <a class="button is-fullwidth is-danger" onClick={this.confirmDeleteMatch.bind(this)}>
                Delete Match
              </a>
            }
          </div>

          <div class="column is-8-desktop">
            <div class="box">
              <h2 class="title is-4">Teams</h2>

              <table class="table is-fullwidth">
                <thead>
                  <tr>
                    <th></th>
                    <th>Team</th>
                    <th>Score</th>
                    <th></th>
                  </tr>
                </thead>

                <tbody>
                  { plays.map((play, index) => {
                      const team = teams.find((team) => team.id == play.team_id);

                      return (
                        <tr>
                          <td width="20px" class="has-padding-right-none">
                            { play.won &&
                              <span class="has-text-primary has-text-right"><FontAwesomeIcon icon="star"/></span>
                            }
                          </td>
                          <td width="60%">
                            {team.name}
                          </td>
                          <td>
                            <input
                              type="number"
                              placeholder="Enter Score"
                              class="input is-content"
                              value={play.score}
                              onInput={(e) => onSetMatchInfo(`match.plays.${index}.score`, e.target.value)}
                            />
                          </td>
                          <td>
                            <a class="button is-white" onClick={this.removePlay.bind(this, team.id)}>
                              <FontAwesomeIcon icon="times"/>
                            </a>
                          </td>
                        </tr>
                      );
                    })
                  }
                </tbody>
              </table>

              <div class="field">
                <label class="label">
                  <input
                    type="checkbox"
                    name="is_finalized"
                    checked={is_finalized}
                    onChange={(e) => onSetMatchInfo('match.is_finalized', e.target.checked)}
                  /> This match is finalized (Scores will be made publicly visible).
                </label>
              </div>

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
                  <button class="button is-primary" onClick={this.addPlay.bind(this)} disabled={!teamToAdd}>Add Team</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
};
