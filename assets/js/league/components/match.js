import _ from 'lodash';
import { h, Component } from 'preact';
import { renderJoined } from '../util';
import { DateTime } from 'luxon';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

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

    const hasFooterContent = match.description || match.video_link;

    const teamsById = _.keyBy(teams, 'id');
    const startDate = DateTime.fromISO(start_date);
    const roundCount = _.chain(plays)
        .map('round')
        .max()
        .value();

    const teamsFromPlays = _.chain(plays)
        .map((play) => teamsById[play.team_id])
        .uniq()
        .value();

    const teamCount = teamsFromPlays.length;
    const matchTableColumnSize = 90.0 / teamCount;

    return (
      <div class="match has-margin-bottom-md">
        <div class="match-header">
          <div class="level">
            <div class="level-start">
              <div class="level-item">
                <p class="match-title">
                  {match.name}
                  <span class="has-text-grey-light"> (#{match.id})</span>
                </p>
              </div>
            </div>

            <div class="level-end">
              <div class="level-item">
                <span class="has-text-weight-normal is-pulled-right">
                  {startDate.toLocaleString(DateTime.DATETIME_MED)}
                </span>
              </div>
            </div>
          </div>
        </div>

        { match.is_featured &&
          <div class="match-banner">
            <FontAwesomeIcon icon="bell" size="sm" className="has-margin-right-xs" />
            This match will be featured on the
            <a href="https://twitch.tv/spyrothon"> Spyrothon Twitch channel.</a>
          </div>
        }

        { match.is_finalized
          ? <div class="match-content">
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
                          <td style="min-width: 50px" class="has-text-right">Round {roundNum}</td>
                          { _.map(teamsFromPlays, (team) => {
                              const play = _.find(plays, {team_id: team.id, round: roundNum})

                              return (
                                <td width={`${matchTableColumnSize}%`} class="has-text-centered">
                                  { play && play.won &&
                                    <FontAwesomeIcon icon="star" size="sm" className="has-text-danger has-margin-right-xs" />
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
          : <div class="has-padding-sm">
              <p class="is-italic has-text-centered">This match has not yet been finalized.</p>
            </div>
        }


        { hasFooterContent &&
          <div class="match-footer">
            <div class="match-description">
              { match.description &&
                <span>
                  <strong>Description: </strong>
                  { match.description }
                </span>
              }
            </div>

            <div class="match-video">
              { match.video_link &&
                <span>
                  <strong>Video: </strong>
                  { match.video_link }
                </span>
              }
            </div>
          </div>
        }
      </div>
    );
  }
};
