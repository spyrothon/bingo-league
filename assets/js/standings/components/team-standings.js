import { h, Component } from 'preact';
import { renderJoined } from '../util';
import { DateTime } from 'luxon';
import linkState from 'linkstate';
import _ from 'lodash';

export class TeamStandings extends Component {
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
                  <span class={`has-margin-left-sm has-margin-right-sm highlight-${team.color}-text-light`}>{index+1}</span>
                  <span>{team.name}</span>
                </p>
                <div class="has-padding-sm is-size-7">
                  <p class={`highlight-${team.color}-text-muted`}><strong>{wins.length}-{losses.length}</strong> after <strong>{matchCount}</strong> Matches</p>
                  <p class={`highlight-${team.color}-text-muted`}>Total Goals: <strong>{totalGoals}</strong></p>
                </div>
              </div>
            );
          })
        }
      </div>
    );
  }
};
