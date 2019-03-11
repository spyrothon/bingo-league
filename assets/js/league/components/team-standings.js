import _ from 'lodash';
import { h, Component } from 'preact';

import { Team } from './team';

export class TeamStandings extends Component {
  render(props) {
    const {
      matches,
      allTeams,
    } = props;

    const sortedTeams = _.chain(allTeams)
        .map((team) => {
          const finalizedPlays = team.plays.filter((play) => play.match.is_finalized);
          return {
            ...team,
            plays: finalizedPlays
          }
        })
        .sortBy([
          (team) => _.filter(team.plays, 'won').length,
          (team) => _.sumBy(team.plays, 'score')
        ])
        .reverse()
        .value();

    console.log(allTeams);

    return (
      <div>
        { _.map(sortedTeams, (team, index) => <Team team={team} rank={index+1} />)
        }
      </div>
    );
  }
};
