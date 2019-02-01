import _ from 'lodash';
import { h, Component } from 'preact';

import { Team } from './team';

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
        { _.map(sortedTeams, (team, index) => <Team team={team} rank={index+1} />)
        }
      </div>
    );
  }
};
