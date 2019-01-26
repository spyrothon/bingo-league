import { h, Component } from 'preact';
import { renderJoined } from '../util';

class Match extends Component {
  render(props) {
    const {
      match,
      plays,
      teams
    } = props;

    return (
      <div class="match">
        <p class="match-title has-text-weight-bold">{match.name}</p>

        <div class="level has-margin-top-md has-margin-bottom-md">
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
        </div>
      </div>
    );
  }
};

export default Match;
