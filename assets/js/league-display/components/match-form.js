import { h, Component } from 'preact';
import linkState from 'linkstate';
import { renderJoined } from '../util';
import Flatpickr from '../../ext/preact-flatpickr';

class MatchForm extends Component {
  constructor(props) {
    super();

    this.emptyMatch = {
      league_id: props.league.id,
      start_date: null,
      name: null,
      plays: [
        { team_id: null, score: null },
        { team_id: null, score: null }
      ]
    }

    this.state = {
      match: { ...this.emptyMatch }
    };
  };

  matchIsValid({league_id, start_date, name, plays}) {
    const playsAreValid = plays.every((p) => !!p.team_id);

    return league_id && start_date && name && playsAreValid;
  }

  createMatch(ev) {
    ev.preventDefault();
    this.props.onSubmit(this.state.match);
    this.setState({ match: { ...this.emptyMatch } });
    return false;
  }

  render(props, state) {
    const { league, teams } = props;
    const {
      match,
    } = state;

    const { plays, start_date } = match;

    const canSubmit = this.matchIsValid(match);

    return (
      <form class="form">
        <div class="field">
          <label class="label">Name</label>
          <div class="control">
            <input class="input" type="text" value={match.name} onChange={linkState(this, 'match.name')} />
          </div>
        </div>

        <div class="field has-margin-top-lg has-margin-bottom-lg">
          <div class="level">
            { renderJoined(plays, (play, idx) => (
                <div class="level-item">
                  <div>
                    <div class="select is-fullwidth">
                      <select value={play.team_id || ""} onChange={linkState(this, `match.plays.${idx}.team_id`)}>
                        <option disabled value="">Select Team</option>
                        { teams.map((team) => (
                            <option key={team.id} value={team.id}>{team.name}</option>
                          ))
                        }
                      </select>
                    </div>
                    <div class="has-margin-top-sm">
                      <input class="input" type="number" value={play.score} onChange={linkState(this, `match.plays.${idx}.score`)} />
                    </div>
                  </div>
                </div>
              ), () => (
                <div class="level-item">
                  <div class="match-vs-separator">
                    <div>
                      <p>vs.</p>
                    </div>
                  </div>
                </div>
              ))
            }
          </div>
        </div>

        <div class="field">
          <label class="label">Date of Play</label>
          <Flatpickr data-enable-time
            class="input"
            value={start_date}
            placeholder="Select a Date"
            onChange={linkState(this, 'match.start_date', '0')}
          />
        </div>

        <div class="field">
          <div class="control">
            <input class="button is-primary" type="submit" value="Create Match" onClick={this.createMatch.bind(this)} disabled={!canSubmit} />
          </div>
        </div>
      </form>
    );
  }
}

export default MatchForm;
