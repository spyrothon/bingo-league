import { h, Component } from 'preact';
import { renderJoined } from '../util';
import { DateTime } from 'luxon';

class Match extends Component {
  render(props) {
    const {
      match,
      plays,
      teams
    } = props;

    const start_date = DateTime.fromISO(match.start_date);

    return (
      <div class="match">
        <p class="match-title">
          <p class="is-pulled-right has-margin-right-sm">{start_date.toLocaleString(DateTime.DATETIME_MED)}</p>
          <p class="has-text-weight-bold">{match.name}</p>
        </p>

        <div class="level has-margin-top-sm">
          <div class="level-item">
          </div>
          { renderJoined(plays, (play) => {
              const team = teams.find((t) => t.id == play.team_id);

              return (
                <div class="level-item has-text-centered">
                  <div>
                    <p>{team.name}</p>
                    <p>{play.score}</p>
                  </div>
                </div>
              );
            }, () => (
              <div class="level-item">
                <div class="match-vs-separator">
                  <div>
                    <p>vs.</p>
                  </div>
                </div>
              </div>
            ))
          }
          <div class="level-item">
          </div>
        </div>
      </div>
    );
  }
};

export default Match;
