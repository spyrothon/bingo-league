import _ from 'lodash';
import { h, Component } from 'preact';
import { renderJoined } from '../util';
import { DateTime } from 'luxon';

export class Match extends Component {
  render(props) {
    const {
      match
    } = props;

    const {
      teams,
      plays
    } = match;

    const teamsById = _.keyBy(teams, 'id');
    const playsByRound = _.groupBy(plays, 'round');

    return (
      <div class="box match has-margin-bottom-lg">
        <h2 class="is-size-5">{match.name}</h2>

        <div class="rounds">
          { _.map(playsByRound, (plays, round) => {
              return (
                <div class="round">
                  <p><strong>Round {round}</strong></p>
                  { plays.map((play) => {
                    return (
                      <div class="play">
                        {play.score} - {teamsById[play.team_id].name}
                      </div>
                    );
                  })}
                </div>
              );
            })
          }
        </div>

        <div class="match-description">
          <strong>Description: </strong>
          { match.description }
        </div>

        <div class="match-video">
          <strong>Video: </strong>
          { match.video_link }
        </div>
      </div>
    );
  }
};
