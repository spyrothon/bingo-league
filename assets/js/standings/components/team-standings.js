import _ from 'lodash';
import { h, Component } from 'preact';
import { renderJoined } from '../util';
import { DateTime } from 'luxon';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import linkState from 'linkstate';

export class TeamStandings extends Component {
  rankDisplay(rank) {
    switch(rank) {
      case 1:
      case 2:
      case 3:
        return <span className="fa-layers fa-fw has-margin-right-sm has-margin-left-sm">
          <FontAwesomeIcon icon="trophy" />
          <span class="fa-layers-text fa-inverse" data-fa-transform="shrink-8.5 up-3.5" style="font-weight:900">{rank}</span>
        </span>;

      default:
        return <span class="fa-fw has-margin-right-sm has-margin-left-sm">{rank}</span>;
    }
  }

  render(props) {
    const {
      matches,
      allTeams,
    } = props;

    const sortedTeams = _.sortBy(allTeams, [
      (team) => _.filter(team.plays, 'won').length,
      (team) => _.sumBy(team.plays, 'score')
    ]).reverse();

    return (
      <div>
        { _.map(sortedTeams, (team, index) => {
            const { plays } = team;
            const [wins, losses] = _.partition(plays, 'won');
            const totalGoals = _.sumBy(plays, 'score');
            const points = wins.length * 2;
            const matchCount = plays.length;

            return (
              <div class={`has-radius has-margin-bottom-md highlight-${team.color}-lighter highlight-${team.color}-shadow`}>
                <p class={`has-padding-xxs has-text-weight-bold highlight-${team.color}`}>
                  <span class="is-pulled-right has-margin-right-sm">{points}</span>
                  {this.rankDisplay(index+1)}
                  <span>{team.name}</span>
                </p>
                <div class="has-padding-sm is-size-7">
                  <p class={`highlight-${team.color}-text-muted`}>
                    <strong> {wins.length}-{losses.length} </strong>
                    after
                    <strong> {matchCount} </strong>
                    matches and
                    <strong> {totalGoals} </strong>
                    goals.
                  </p>
                </div>
              </div>
            );
          })
        }
      </div>
    );
  }
};
