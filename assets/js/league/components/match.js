import _ from 'lodash';
import { h, Component } from 'preact';
import { DateTime } from 'luxon';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

const DATETIME_CONFIG = {
  weekday: 'short',
  month: 'short',
  day: '2-digit',
  hour: '2-digit',
  minute: '2-digit',
  timeZoneName: 'short'
};

export class Match extends Component {
  constructor(props) {
    super(props);
    this.state = {
      isExpanded: false
    };
  }

  onExpand() {
    console.log("no")
    this.setState({
      isExpanded: true
    });
  }

  onCollapse() {
    this.setState({
      isExpanded: false
    });
  }

  render() {
    const {
      match
    } = this.props;
    const {
      isExpanded
    } = this.state;

    const {
      teams,
      plays,
      start_date
    } = match;

    const hasFooterContent =
        match.description ||
        match.video_link ||
        match.room_link ||
        match.board_image_link;

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
                  {startDate.toLocaleString(DATETIME_CONFIG)}
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

        { hasFooterContent && isExpanded
          ? <div class="match-footer">
              <div class="match-footer-text">
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
                      <a href={match.video_link} target="_blank" rel="nofollow noopener">{ match.video_link }</a>
                    </span>
                  }
                </div>

                <div class="match-room">
                  { match.room_link &&
                    <span>
                      <strong>Room: </strong>
                      <a href={match.room_link} target="_blank" rel="nofollow noopener">{ match.room_link }</a>
                    </span>
                  }
                </div>

                <div class="match-board-image">
                  { match.board_image_link &&
                    <span>
                      <strong>Final Board: </strong>
                      <img src={match.board_image_link} />
                    </span>
                  }
                </div>
              </div>

              <div class="match-expand-target" onClick={this.onCollapse.bind(this)}>
                <span>Show Less</span>
              </div>
            </div>
          : hasFooterContent &&
            <div>
              <div class="match-expand-target" onClick={this.onExpand.bind(this)}>
                <span>Show More</span>
              </div>
            </div>
        }
      </div>
    );
  }
};
