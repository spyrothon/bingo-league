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
      plays,
      start_date
    } = match;

    const teamsById = _.keyBy(teams, 'id');
    const startDate = DateTime.fromISO(start_date);
    const roundCount = _.chain(plays)
        .map('round')
        .max()
        .value();
    console.log(roundCount)

    const teamsFromPlays = _.chain(plays)
        .map((play) => teamsById[play.team_id])
        .uniq()
        .value();

    return (
      <div class="match has-margin-bottom-md">
        <div class="match-header">
          <span class="is-pulled-right has-text-weight-normal">
            {startDate.toLocaleString(DateTime.DATETIME_MED)}
          </span>
          <p>{match.name}</p>
        </div>

        <div class="match-content">
          <table class="match-table">
            <thead>
              <tr>
                <th></th>
                { teamsFromPlays.map((team) => <th class="has-text-centered">{team.name}</th>) }
              </tr>
            </thead>

            <tbody>
              { _.times(roundCount, (roundIndex) => {
                  const roundNum = roundIndex + 1;
                  return (
                    <tr>
                      <td width="60px" class="has-text-right">Round {roundNum}</td>
                      { _.map(teamsFromPlays, (team) => {
                          const play = _.find(plays, {team_id: team.id, round: roundNum})

                          return (
                            <td class="has-text-centered">
                              { play && play.won &&
                                <span class="has-text-danger has-text-right">&#9733; </span>
                              }
                              { play
                                ? play.score
                                : <span>&ndash;</span>
                              }
                            </td>
                          );
                        })
                      }
                    </tr>
                  );
                })
              }
            </tbody>
          </table>
        </div>
        <div class="match-footer">
          <div class="match-description">
            <strong>Description: </strong>
            { match.description }
          </div>

          <div class="match-video">
            <strong>Video: </strong>
            { match.video_link }
          </div>
        </div>
      </div>
    );
  }
};
