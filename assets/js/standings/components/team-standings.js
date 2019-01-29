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

    const sortedTeams = _.sortBy(allTeams,[
      (team) => _.filter(team.plays, 'won').length,
      (team) => _.sumBy(team.plays, 'score')
    ]).reverse();

    return (
      <div>
        { _.map(sortedTeams, (team, index) => {
            const { plays } = team;
            const [wins, losses] = _.partition(plays, 'won');
            const totalGoals = _.sumBy(plays, 'score');
            return (
              <div class="has-margin-top-md has-margin-bottom-md">
                <p class="is-size-5">
                  <span class="has-text-grey-light has-text-weight-bold">{index + 1}</span>
                  &nbsp;
                  <span class="has-text-weight-bold">{team.name}</span>
                </p>
                <p class="has-text-grey">{wins.length} Wins - {losses.length} Losses - {totalGoals} Total Goals</p>
              </div>
            );
          })
        }
      </div>
    );
  }
};
